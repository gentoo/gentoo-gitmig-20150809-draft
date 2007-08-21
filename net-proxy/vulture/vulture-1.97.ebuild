# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/vulture/vulture-1.97.ebuild,v 1.1 2007/08/21 19:46:14 mrness Exp $

inherit eutils

DESCRIPTION="INTRINsec Reverse Proxy"
HOMEPAGE="http://vulture.open-source.fr/"
SRC_URI="http://vulture.open-source.fr/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/perl-ldap
	dev-perl/Apache-Session
	=dev-perl/DBD-SQLite-0.31*
	dev-perl/DBD-Pg
	dev-perl/DBD-mysql
	dev-perl/IPC-Run
	dev-perl/libwww-perl
	>=dev-perl/crypt-cbc-2.15
	dev-perl/Crypt-Blowfish
	dev-perl/Digest-SHA1
	=dev-db/sqlite-2.8*
	>=www-apache/mod_perl-2.0.1
	virtual/httpd-php
	dev-libs/openssl"

RDEPEND="${DEPEND}
	www-apache/mod_security
	>=www-servers/apache-2.2.4
	app-admin/sudo"

INTRINsec_HOME="/opt/INTRINsec"

src_unpack() {
	unpack ${A}

	cd "${S}"
	EPATCH_SUFFIX="patch"
	epatch "${WORKDIR}"/${P}/ebuild/*.patch || die "epatch failed"
}

src_compile() {
	sqlite sql/db < sql/sqlite.dump
	sqlite sql/sessions < sql/sessions.dump
	rm -f lib/Vulture/Makefile
	local libpath=$(perl -MConfig -e 'print $Config{sitelib}')
	make OPT=LIB="${D}/${libpath}"
	cd lib/SSLLookup && perl Makefile.PL DESTDIR="${D}" && make CCFLAGS=-I/usr/include/apr-0
	rm -f ../../lib/Authen-Radius-0.12/install-radius-db.PL
	cd ../../lib/Data-HexDump-0.02 && perl Makefile.PL && make
	cd ../../lib/Authen-Radius-0.12 && perl Makefile.PL && make
}

src_install () {
	make PREFIX="${D}${INTRINsec_HOME}" NAME=${PN} install
	make -C lib/SSLLookup install
	make -C lib/Data-HexDump-0.02 DESTDIR="${D}" install
	make -C lib/Authen-Radius-0.12 DESTDIR="${D}" install

	insinto /etc/raddb
	doins lib/Authen-Radius-0.12/raddb/dictionary*
	fowners apache:apache "${INTRINsec_HOME}"/${PN}
	insopts -m0600 -o apache -g apache
	insinto "${INTRINsec_HOME}"/${PN}/conf
	doins ebuild/httpd.conf
	insinto "${INTRINsec_HOME}"/${PN}/www
	doins ebuild/config.php
	insinto "${INTRINsec_HOME}"/${PN}/sql
	doins sql/db
	newinitd ebuild/vulture.rc vulture
}

pkg_postinst() {
	openssl req -x509 -newkey rsa:2048 -batch -nodes\
		-config "${INTRINsec_HOME}"/${PN}/conf/openssl.cnf\
		-out "${INTRINsec_HOME}"/${PN}/conf/vulture.crt\
		-keyout "${INTRINsec_HOME}"/${PN}/conf/vulture.key
	einfo "Vulture is installed. You can now type the following :"
	einfo "echo \"apache ALL=NOPASSWD:/usr/sbin/apache2\" >> /etc/sudoers"
}
