# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/otrs/otrs-2.1.5.ebuild,v 1.5 2007/08/19 11:40:10 hollow Exp $

inherit webapp eutils

IUSE="mysql postgres fastcgi ldap gd pdf"

DESCRIPTION="OTRS is an Open source Ticket Request System"
HOMEPAGE="http://otrs.org/"
SRC_URI="ftp://ftp.otrs.org/pub/${PN}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="
	${DEPEND}
	=dev-lang/perl-5*
	dev-perl/Date-Pcalc
	dev-perl/TimeDate
	dev-perl/Crypt-PasswdMD5
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
	virtual/mta
	pdf? ( dev-perl/PDF-API2 )
	ldap? ( dev-perl/perl-ldap net-nds/openldap )
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	>=www-servers/apache-2
	fastcgi? ( dev-perl/FCGI )
	!fastcgi? ( =www-apache/libapreq2-2* )
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

	# http://bugs.otrs.org/show_bug.cgi?id=1231
	cd ${S}
	epatch ${FILESDIR}/dbi_finish.patch

	cd ${S}/Kernel/Config/
	for foo in *.dist; do cp ${foo} $(basename ${foo} .dist); done

	cd ${S}/scripts
	rm -rf auto_* redhat* suse*

	if use fastcgi; then
		epatch ${FILESDIR}/apache2.patch
		sed -e "s|cgi-bin|fcgi-bin|" -i ${S}/scripts/apache2-httpd.include.conf
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
