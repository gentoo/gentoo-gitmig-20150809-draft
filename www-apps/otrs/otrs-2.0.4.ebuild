# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/otrs/otrs-2.0.4.ebuild,v 1.6 2006/10/20 02:45:53 rl03 Exp $

inherit webapp eutils

S=${WORKDIR}/${PN}

IUSE="mysql postgres fastcgi apache2 ldap gd"

DESCRIPTION="OTRS is an Open source Ticket Request System"
HOMEPAGE="http://otrs.org/"
SRC_URI="ftp://ftp.otrs.org/pub/${PN}/${P}-01.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="
	=dev-lang/perl-5*
	dev-perl/Date-Pcalc
	dev-perl/TimeDate
	dev-perl/DBI
	virtual/perl-CGI
	virtual/perl-Digest-MD5
	dev-perl/libwww-perl
	dev-perl/IO-stringy
	virtual/perl-MIME-Base64
	dev-perl/MIME-tools
	dev-perl/MailTools
	dev-perl/Net-DNS
	virtual/perl-libnet
	dev-perl/Authen-SASL
	dev-perl/XML-Parser
"

RDEPEND="
	${DEPEND}
	virtual/mta
	ldap? ( dev-perl/perl-ldap net-nds/openldap )
	mysql? ( =dev-db/mysql-4* dev-perl/DBD-mysql )
	postgres? ( dev-db/postgresql dev-perl/DBD-Pg )
	apache2? ( >=net-www/apache-2
		fastcgi? ( dev-perl/FCGI net-www/mod_fastcgi )
		!fastcgi? ( =www-apache/libapreq2-2* ) )
	!apache2? ( =net-www/apache-1*
		fastcgi? ( dev-perl/FCGI net-www/mod_fastcgi )
		!fastcgi? ( =www-apache/libapreq-1* ) )
	gd? ( dev-perl/GD dev-perl/GDTextUtil dev-perl/GDGraph )
"

LICENSE="GPL-2"

pkg_setup() {
	webapp_pkg_setup
	enewuser otrs -1 -1 /dev/null apache
}

src_unpack() {
	unpack ${A}
	cp ${S}/Kernel/Config.pm.dist ${S}/Kernel/Config.pm
	cd ${S}/Kernel/Config/
	for foo in *.dist; do cp ${foo} $(basename ${foo} .dist); done

	cd ${S}/scripts
	rm -rf auto_* redhat* suse*

	if use fastcgi; then
		if ! use apache2; then
			epatch ${FILESDIR}/apache1.patch
			sed -e "s|cgi-bin|fcgi-bin|" -i ${S}/scripts/apache-httpd.include.conf
		fi
		if use apache2; then
			epatch ${FILESDIR}/apache2.patch
			sed -e "s|cgi-bin|fcgi-bin|" -i ${S}/scripts/apache2-httpd.include.conf
		fi
		sed -e "s|index.pl|index.fpl|" -i ${S}/var/httpd/htdocs/index.html
	fi
}

src_install() {
	webapp_src_preinst
	dodir ${MY_HOSTROOTDIR}/${PF}

	# install documentation
	dodoc CHANGES CREDITS INSTALL README* TODO UPGRADING \
		doc/otrs-database.dia doc/test-* doc/X-OTRS-Headers.txt \
		.fetchmailrc.dist .mailfilter.dist .procmailrc.dist
	dohtml doc/manual/{en,de}/html/*

	# copy main files
	cp -R .fetchmailrc.dist .mailfilter.dist .procmailrc.dist RELEASE Kernel bin scripts var ${D}/${MY_HOSTROOTDIR}/${PF}
	mv ${D}/${MY_HOSTROOTDIR}/${PF}/var/httpd/htdocs/* ${D}/${MY_HTDOCSDIR}

	# remove stuff from ${D} that shouldn't be there
	rm -rf ${D}/${MY_HOSTROOTDIR}/${PF}/var/httpd

	# keep some empty dirs
	local a
	local d="article log pics/images pics/stats pics sessions spool tmp"
	for a in ${d}; do
		keepdir ${MY_HOSTROOTDIR}/${PF}/var/${a}
	done

	# helpers
	webapp_configfile ${MY_HOSTROOTDIR}/${PF}/Kernel/Config.pm
	webapp_postinst_txt en ${FILESDIR}/postinstall-en-2.txt
	webapp_hook_script ${FILESDIR}/reconfig-2
	webapp_src_install
}

pkg_postinst() {
	ewarn "webapp-config will not be run automatically"
	ewarn "That messes up Apache configs"
	ewarn "Don't run webapp-config with -d otrs. Instead, try"
	ewarn "webapp-config -I -h <host> -d ot ${PN} ${PVR}"
	ewarn
	# webapp_pkg_postinst
}
