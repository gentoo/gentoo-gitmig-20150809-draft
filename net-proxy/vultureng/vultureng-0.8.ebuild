# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/vultureng/vultureng-0.8.ebuild,v 1.2 2005/08/18 14:17:53 dams Exp $

inherit flag-o-matic eutils

DESCRIPTION="INTRINsec Reverse Proxy"
HOMEPAGE="http://vulture.open-source.fr"
SRC_URI="http://vulture.open-source.fr/download/VultureNG-${PV}.tar.bz2"
S=${WORKDIR}/VultureNG-${PV}
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

INTRINsec_HOME="/opt/INTRINsec"

RDEPEND="dev-lang/perl
dev-perl/perl-ldap
dev-perl/Apache-Session
=dev-perl/DBD-SQLite-0.31
dev-perl/DBD-Pg
dev-perl/libwww-perl
net-www/mod_security
>=www-apache/mod_perl-1.99
>=net-www/apache-2.0.52
virtual/httpd-php
dev-php/PECL-sqlite
app-admin/sudo
net-www/mod_ssl
dev-libs/openssl"

DEPEND="dev-libs/openssl
dev-db/sqlite
dev-lang/perl"

src_compile() {
	sed -i -e 's|/opt/INTRINsec/VultureNG|/opt/INTRINsec/vultureng|g'\
		www/WEB-INF/phpmvc-config.xml sql/sqlite.dump
	sqlite sql/db < sql/sqlite.dump
	rm -f lib/Vulture/Makefile
	libpath=`perl -MConfig -e 'print $Config{sitelib}'`
	make OPT=LIB=${D}/${libpath}
}

src_install () {
	make PREFIX=${D}${INTRINsec_HOME} NAME=${PN} install
	fowners apache:apache ${INTRINsec_HOME}/${PN}
	insopts -m0600 -o apache -g apache
	insinto ${INTRINsec_HOME}/${PN}/conf
	doins ebuild/httpd.conf
	insinto ${INTRINsec_HOME}/${PN}/www
	doins ebuild/config.php
	insinto ${INTRINsec_HOME}/${PN}/sql
	doins sql/db
#	insinto /etc/init.d
#	insopts -m0750 -o root -g root
#	newins ebuild/VultureNG.init vultureng
	newinitd ebuild/VultureNG.init vultureng
}

pkg_postinst() {
	openssl req -x509 -newkey rsa:2048 -batch -nodes\
		-config ${INTRINsec_HOME}/${PN}/conf/openssl.cnf\
		-out ${INTRINsec_HOME}/${PN}/conf/vultureng.crt\
		-keyout ${INTRINsec_HOME}/${PN}/conf/vultureng.key
	einfo "Vulture is installed. You can now type the following :"
	einfo "echo \"apache ALL=NOPASSWD:/usr/sbin/apache2,/bin/kill\" >> /etc/sudoers"
}
