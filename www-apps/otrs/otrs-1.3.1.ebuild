# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/otrs/otrs-1.3.1.ebuild,v 1.1 2004/09/26 12:40:40 rl03 Exp $

inherit webapp eutils

S=${WORKDIR}/${PN}

IUSE="mysql postgres fastcgi apache2 ldap"

DESCRIPTION="OTRS is an Open source Ticket Request System"
HOMEPAGE="http://otrs.org/"
SRC_URI="ftp://ftp.gwdg.de/pub/misc/${PN}/${P}-01.tar.bz2
	http://otrs.behrsolutions.com/${P}-01.tar.bz2
	ftp://ftp.samurai.com/pub/${PN}/${P}-01.tar.bz2
	ftp://ftp.otrs.org/pub/${PN}/${P}-01.tar.bz2
	http://ftp.gwdg.de/pub/misc/${PN}/${P}-01.tar.bz2"

KEYWORDS="~x86 ~ppc"

DEPEND="
	=dev-lang/perl-5*
	dev-perl/Date-Pcalc
	dev-perl/DBI
	dev-perl/Email-Valid
	dev-perl/IO-stringy
	dev-perl/MIME-tools
	dev-perl/MailTools
	dev-perl/Net-DNS
	dev-perl/Authen-SASL
	dev-perl/GD
	dev-perl/GDTextUtil
	dev-perl/GDGraph
"

RDEPEND="
	${DEPEND}
	virtual/mta
	ldap? ( dev-perl/perl-ldap net-nds/openldap )
	mysql? ( =dev-db/mysql-4* dev-perl/DBD-mysql )
	postgres? ( dev-db/postgresql dev-perl/DBD-Pg )
	fastcgi? ( dev-perl/FCGI net-www/mod_fastcgi )
	apache2? ( >=net-www/apache-2 dev-perl/FCGI net-www/mod_fastcgi )
	!apache2? ( =net-www/apache-1* =dev-perl/libapreq-1* )
	"

LICENSE="GPL-2"

pkg_setup() {
	webapp_pkg_setup
	einfo
	einfo "File locations have changed. OTRS now installs into"
	einfo "/var/www/<YOURHOST>/${P}, /var/www/<YOURHOST>/cgi-bin/${PN}, and "
	einfo "/var/www/<YOURHOST>/htdocs/${PN}"
	einfo
	enewuser otrs -1 /bin/false /dev/null apache

	use apache2 && ewarn "mod_perl2 isn't ready for prime time, fastcgi will be used instead"
}

src_compile() {
	# check dependenices
	cp ${S}/Kernel/Config.pm.dist ${S}/Kernel/Config.pm
	cd ${S}/Kernel/Config/
	for foo in *.dist; do cp ${foo} `basename ${foo} .dist`; done

	cd ${S}
	if ! perl -cw bin/cgi-bin/index.pl 2>&1 | grep -q "syntax OK"; then die "Unresolved Perl dependencies"; fi
	if ! perl -cw bin/PostMaster.pl 2>&1 | grep -q "syntax OK"; then die "Unresolved Perl dependencies"; fi
}

src_install() {
	webapp_src_preinst
	dodir ${MY_HOSTROOTDIR}/${P} ${MY_CGIBINDIR}/${PN}

	# install documentation
	dodoc CHANGES CREDITS INSTALL README* TODO UPGRADING
	dohtml doc/manual/en/html/*

	cp -R Kernel bin scripts var \
		.fetchmailrc .mailfilter .procmailrc ${D}/${MY_HOSTROOTDIR}/${P}
	cp -R bin/cgi-bin/* ${D}/${MY_CGIBINDIR}/${PN}
	mv ${D}/${MY_HOSTROOTDIR}/${P}/var/httpd/htdocs/* ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HOSTROOTDIR}/${P}/var/httpd ${D}/${MY_HOSTROOTDIR}/${P}/bin/cgi-bin

	webapp_configfile ${MY_HOSTROOTDIR}/${P}/Kernel/Config.pm

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-${PV}.txt
	webapp_hook_script ${FILESDIR}/reconfig-${PV}
	webapp_src_install
}
