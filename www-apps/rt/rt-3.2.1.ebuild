# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/rt/rt-3.2.1.ebuild,v 1.7 2005/08/24 20:16:00 rl03 Exp $

inherit webapp eutils

IUSE="mysql postgres fastcgi"
#IUSE="mysql postgres fastcgi apache2"

DESCRIPTION="RT is an industrial-grade ticketing system"
HOMEPAGE="http://www.bestpractical.com/rt/"
SRC_URI="http://www.fsck.com/pub/${PN}/release/${P}.tar.gz
	ftp://ftp.eu.uu.net/pub/unix/ticketing/${PN}/release/${P}.tar.gz
	ftp://rhinst.ece.cmu.edu/${PN}/release/${P}.tar.gz"

KEYWORDS="~x86 ~ppc"

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
	dev-perl/HTML-Tree
	dev-perl/HTML-Format
	dev-perl/libwww-perl
	>=dev-perl/Apache-DBI-0.92
	>=dev-perl/DBI-1.37
	dev-perl/Test-Inline
	>=dev-perl/class-returnvalue-0.40
	>=dev-perl/dbix-searchbuilder-1.01
	dev-perl/text-template
	dev-perl/HTML-Parser
	>=dev-perl/HTML-Scrubber-0.08
	>=dev-perl/log-dispatch-2.0
	>=dev-perl/locale-maketext-lexicon-0.32
	dev-perl/locale-maketext-fuzzy
	>=dev-perl/MIME-tools-5.411a-r2
	>=dev-perl/MailTools-1.60
	dev-perl/text-wrapper
	dev-perl/Time-modules
	dev-perl/TermReadKey
	dev-perl/text-autoformat
	>=dev-perl/Text-Quoted-1.3
	>=dev-perl/Tree-Simple-1.04
	dev-perl/Module-Versions-Report
	dev-perl/regexp-common
	dev-perl/WWW-Mechanize

	dev-perl/Font-AFM
	dev-perl/text-autoformat
	dev-perl/text-reform
"

RDEPEND="
	${DEPEND}
	virtual/mta
	mysql? ( >=dev-db/mysql-4.0.13 >=dev-perl/DBD-mysql-2.0416 )
	postgres? ( >=dev-db/postgresql-7.4.2-r1 dev-perl/DBD-Pg )
	fastcgi? ( dev-perl/FCGI net-www/mod_fastcgi )
	!fastcgi? ( =www-apache/libapreq-1* )
	=net-www/apache-1*
"
#	apache2? ( >=net-www/apache-2 dev-perl/FCGI net-www/mod_fastcgi )
#	!apache2? ( =net-www/apache-1* =www-apache/libapreq-1* )

LICENSE="GPL-2"

pkg_setup() {
	webapp_pkg_setup

#	if use apache2; then
#		ewarn "mod_perl2 isn't ready for prime time, fastcgi will be used instead"
#		ewarn "If you really want mod_perl2, you can edit the ebuild and uncomment a few lines"
#		ewarn "but if your RT breaks, you get to keep the pieces."
#		ewarn
#	fi
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
	sed -e "s|/opt/rt3/bin/rt-mailgate|/usr/bin/rt-mailgate|g" -i README
}

src_compile() {
	# capture the list of files from configure to patch later on
	files=`./configure --prefix=${D}/usr \
		--with-web-user=apache \
		--with-web-group=apache | grep creating | cut -d':' -f2 | cut -d' ' -f3`
	# ./configure doesn't accept locations, so patch these files directly
	sed -i "s|/usr/etc|${MY_HOSTROOTDIR}/rt-config|
			s|/usr/man|/usr/share/man|
			s|/usr/var|/var|
			s|/var/mason_data|/var/rt/mason_data|
			s|/var/session_data|/var/rt/session_data|
			s|/var/log|/var/log/rt|
			s|/usr/local/html|${MY_HTDOCSDIR}|
			s|/usr/share/html|${MY_HTDOCSDIR}|
			s|/usr/local|${MY_HOSTROOTDIR}/rt|
	" ${files}

	# check for missing deps and ask to report if something is broken
	/usr/bin/perl ./sbin/rt-test-dependencies --verbose \
		`use_with mysql` \
		`use_with postgres pg` > ${T}/t
	if grep -q "MISSING" ${T}/t; then
		ewarn "Missing Perl dependency!"
		ewarn
		cat ${T}/t
		ewarn
		ewarn "Please file a bug in the Gentoo Bugzilla with the information above"
		ewarn "and assign it to rl03@gentoo.org"
		die "Missing dependencies."
	fi
}

src_install() {
	webapp_src_preinst

	dodoc README Changelog
	rm -f COPYING README Changelog

	make install

	# copy upgrade schemas
	cd etc
	cp -R upgrade ${D}/${MY_HOSTROOTDIR}/rt-config

	# delete RT_SiteConfig.pm so we don't accidentally overwrite existing
	# configuration
	rm -f ${D}/${MY_HOSTROOTDIR}/rt-config/RT_SiteConfig.pm

	cd ${D}
	grep -Rl "${D}" * | xargs dosed
	chmod +r ${D}/${MY_HOSTROOTDIR}/rt-config/RT*

	webapp_postinst_txt en ${FILESDIR}/${PV}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/${PV}/reconfig
	webapp_src_install
}
