# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/otrs/otrs-1.2.4.ebuild,v 1.3 2004/09/03 17:17:21 pvdabeel Exp $

inherit webapp

S=${WORKDIR}/${PN}

IUSE="mysql postgres fastcgi apache2 ldap"

DESCRIPTION="OTRS is an Open source Ticket Request System"
HOMEPAGE="http://otrs.org/"
SRC_URI="ftp://ftp.gwdg.de/pub/misc/${PN}/${P}-01.tar.bz2
	http://otrs.behrsolutions.com/${P}-01.tar.bz2
	ftp://ftp.samurai.com/pub/${PN}/${P}-01.tar.bz2
	ftp://ftp.otrs.org/pub/${PN}/${P}-01.tar.bz2
	http://ftp.gwdg.de/pub/misc/${PN}/${P}-01.tar.bz2"

KEYWORDS="~x86 ppc"

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

	if use apache2; then
		ewarn "mod_perl2 isn't ready for prime time, fastcgi will be used instead"
		ewarn "If you really want mod_perl2, you can edit the ebuild and uncomment a few lines"
		ewarn "but if your OTRS breaks, you get to keep the pieces."
		ewarn
	fi
}

src_compile() {
	# check dependenices
	cp ${S}/Kernel/Config.pm.dist ${S}/Kernel/Config.pm
	cd ${S}/Kernel/Config/
	for foo in *.dist; do cp ${foo} `basename ${foo} .dist`; done

	cd ${S}
	if ! perl -cw bin/cgi-bin/index.pl 2>&1 | grep -q "syntax OK"; then die "Unresolved Perl dependencies"; fi
	if ! perl -cw bin/PostMaster.pl 2>&1 | grep -q "syntax OK"; then die "Unresolved Perl dependencies"; fi

	# remove configs so we don't accidentally overwrite existing configs
	rm -f ${S}/Kernel/Config.pm
	cd ${S}/Kernel/Config/
	for foo in *.dist; do rm -f `basename ${foo} .dist`; done
}

src_install() {
	webapp_src_preinst
	dodir ${MY_CGIBINDIR}/${PN}

	# install documentation
	rm -f COPYING
	for file in README* CHANGES CREDITS RELEASE UPGRADING INSTALL TODO; do
		dodoc ${file}; rm -f ${file}
	done

	cp -R Kernel ${D}/${MY_HOSTROOTDIR}
	cp -R bin/cgi-bin/*  ${D}/${MY_CGIBINDIR}/${PN}
	dodir /usr/bin
	cp bin/* ${D}/usr/bin

	dohtml doc/manual/en/html/*

	cp -R scripts  ${D}/${MY_HOSTROOTDIR}

	dodir var/otrs
	cp -R var/article var/cron var/pics var/sessions var/spool ${D}/var/otrs
	sed -i "s|\$HOME|/usr|g" ${D}/var/otrs/cron/*
	cp -R var/httpd/htdocs/*  ${D}/${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_src_install
}
