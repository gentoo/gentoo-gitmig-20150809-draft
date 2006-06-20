# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/vultureng/vultureng-1.1.1.ebuild,v 1.1 2006/06/20 04:12:17 mrness Exp $

inherit flag-o-matic eutils depend.php

DESCRIPTION="INTRINsec Reverse Proxy"
HOMEPAGE="http://vulture.open-source.fr"
SRC_URI="http://vulture.open-source.fr/download/VultureNG-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/perl-ldap
	dev-perl/Apache-Session
	=dev-perl/DBD-SQLite-0.31
	dev-perl/DBD-Pg
	dev-perl/libwww-perl
	dev-perl/crypt-cbc
	dev-perl/Digest-SHA1
	=dev-db/sqlite-2.8*
	>=www-apache/mod_perl-2.0.1
	virtual/httpd-php
	dev-libs/openssl"
RDEPEND="${DEPEND}
	>=net-www/apache-2.0.52
	net-www/mod_security
	app-admin/sudo"

S="${WORKDIR}/VultureNG-${PV}"
INTRINsec_HOME="/opt/INTRINsec"

pkg_setup() {
	require_sqlite;
}

src_compile() {
	sed -i -e 's|/opt/INTRINsec/VultureNG|/opt/INTRINsec/vultureng|g'\
		www/WEB-INF/phpmvc-config.xml sql/sqlite.dump\
		lib/Vulture/lib/Vulture/ResponseHandler.pm\
		lib/Vulture/lib/Vulture.pm
	sqlite sql/db < sql/sqlite.dump
	sqlite sql/sessions < sql/sessions.dump
	rm -f lib/Vulture/Makefile
	libpath=`perl -MConfig -e 'print $Config{sitelib}'`
	make OPT=LIB="${D}/${libpath}" || die "make failed"
	cd lib/SSLLookup && perl Makefile.PL DESTDIR="${D}" && make CCFLAGS=-I/usr/include/apr-0 || die "lib/SSLLookup : make failed"
}

src_install () {
	make PREFIX="${D}${INTRINsec_HOME}" NAME="${PN}" install || die "make install failed"
	make -C lib/SSLLookup install || die "lib/SSLLookup : make install failed"

	fowners apache:apache "${INTRINsec_HOME}/${PN}"
	insopts -m0600 -o apache -g apache
	insinto "${INTRINsec_HOME}/${PN}/conf"
	doins ebuild/httpd.conf
	insinto "${INTRINsec_HOME}/${PN}/www"
	doins ebuild/config.php
	insinto "${INTRINsec_HOME}/${PN}/sql"
	doins sql/db

	newinitd ebuild/VultureNG.init vultureng
}

pkg_postinst() {
	openssl req -x509 -newkey rsa:2048 -batch -nodes \
		-config "${INTRINsec_HOME}/${PN}/conf/openssl.cnf" \
		-out "${INTRINsec_HOME}/${PN}/conf/vultureng.crt" \
		-keyout "${INTRINsec_HOME}/${PN}/conf/vultureng.key"
	einfo "Vulture is installed. You can now type the following :"
	einfo "echo \"apache ALL=NOPASSWD:/usr/sbin/apache2,/bin/kill\" >> /etc/sudoers"
}
