# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/rt/rt-3.4.2.ebuild,v 1.1 2005/06/12 20:03:35 rl03 Exp $

inherit webapp eutils

IUSE="mysql postgres fastcgi"
#IUSE="mysql postgres fastcgi apache2"

DESCRIPTION="RT is an enterprise-grade ticketing system"
HOMEPAGE="http://www.bestpractical.com/rt/"
SRC_URI="http://download.bestpractical.com/pub/${PN}/release/${P}.tar.gz
	ftp://ftp.eu.uu.net/pub/unix/ticketing/${PN}/release/${P}.tar.gz
	ftp://rhinst.ece.cmu.edu/${PN}/release/${P}.tar.gz"

KEYWORDS="~x86"

DEPEND="
	>=dev-lang/perl-5.8.3
	>=dev-perl/Params-Validate-0.02
	dev-perl/Cache-Cache
	>=dev-perl/Exception-Class-1.14
	>=dev-perl/HTML-Mason-1.23
	dev-perl/MLDBM
	dev-perl/FreezeThaw
	>=dev-perl/Apache-Session-1.53
	dev-perl/XML-RSS
	>=dev-perl/HTTP-Server-Simple-0.07
	>=dev-perl/HTTP-Server-Simple-Mason-0.05
	dev-perl/HTML-Tree
	dev-perl/HTML-Format
	dev-perl/libwww-perl
	>=dev-perl/Apache-DBI-0.92
	>=dev-perl/DBI-1.37
	dev-perl/Test-Inline
	>=dev-perl/class-returnvalue-0.40
	>=dev-perl/dbix-searchbuilder-1.27
	dev-perl/text-template
	dev-perl/HTML-Parser
	>=dev-perl/HTML-Scrubber-0.08
	>=dev-perl/log-dispatch-2.0
	>=dev-perl/locale-maketext-lexicon-0.32
	dev-perl/locale-maketext-fuzzy
	>=dev-perl/MIME-tools-5.417
	>=dev-perl/MailTools-1.60
	dev-perl/text-wrapper
	dev-perl/Time-modules
	dev-perl/TermReadKey
	>=dev-perl/Text-Quoted-1.3
	>=dev-perl/Tree-Simple-1.04
	dev-perl/Module-Versions-Report
	dev-perl/Cache-Simple-TimedExpiry
	dev-perl/XML-Simple
	dev-perl/regexp-common
	dev-perl/Apache-Test
	dev-perl/WWW-Mechanize
	dev-perl/Test-WWW-Mechanize
	dev-perl/Module-Refresh

	dev-perl/Font-AFM
	dev-perl/text-autoformat
	dev-perl/text-reform
"

RDEPEND="
	${DEPEND}
	virtual/mta
	mysql? ( >=dev-db/mysql-4.0.13 >=dev-perl/DBD-mysql-2.1018 )
	postgres? ( >=dev-db/postgresql-7.4.2-r1 >=dev-perl/DBD-Pg-1.41 )
	fastcgi? ( dev-perl/FCGI net-www/mod_fastcgi )
	!fastcgi? ( =www-apache/libapreq-1* )
	=net-www/apache-1*"

#	apache2? ( >=net-www/apache-2 >=www-apache/libapreq2 )
#	!apache2? ( =net-www/apache-1* =www-apache/libapreq-1* )


LICENSE="GPL-2"

pkg_setup() {
	webapp_pkg_setup

	ewarn "RT needs MySQL with innodb support"
	ewarn
	ewarn "If you are upgrading from an existing _RT2_ installation,"
	ewarn "stop this ebuild (Ctrl-C now), download the upgrade tool,"
	ewarn "http://bestpractical.com/pub/rt/devel/rt2-to-rt3.tar.gz"
	ewarn "and follow the included instructions."
	ewarn
	enewgroup rt >/dev/null
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# add Gentoo-specific layout
	cat ${FILESDIR}/config.layout-gentoo >> config.layout
	sed -e "s|PREFIX|${D}/${MY_HOSTROOTDIR}/${P}|
			s|HTMLDIR|${D}/${MY_HTDOCSDIR}|g" -i ./config.layout

}

src_compile() {
	./configure --enable-layout=Gentoo \
		--with-web-user=apache \
		--with-web-group=apache

	# check for missing deps and ask to report if something is broken
	if `make testdeps | grep "MISSING"`; then
		ewarn "Missing Perl dependency!"
		ewarn "Please file a bug in the Gentoo Bugzilla with the information above"
		ewarn "and assign it to rl03@gentoo.org"
		die "Missing dependencies."
	fi
}

src_install() {
	webapp_src_preinst

	make install

	# copy upgrade files
	cp -R etc/upgrade ${D}/${MY_HOSTROOTDIR}/${P}

	# make sure we don't clobber existing site configuration
	rm -f ${D}/${MY_HOSTROOTDIR}/${P}/etc/RT_SiteConfig.pm

	cd ${D}
	grep -Rl "${D}" * | xargs dosed
	chmod +r ${D}/${MY_HOSTROOTDIR}/${P}/etc/RT*

	webapp_server_configfile apache1 ${FILESDIR}/rt_apache.conf
	webapp_postinst_txt en ${FILESDIR}/postinstall-en-${PV}.txt
	webapp_hook_script ${FILESDIR}/reconfig-${PV}
	webapp_src_install
}
