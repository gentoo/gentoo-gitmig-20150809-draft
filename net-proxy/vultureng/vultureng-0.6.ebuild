# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/vultureng/vultureng-0.6.ebuild,v 1.1 2005/05/24 21:04:36 dams Exp $

inherit flag-o-matic eutils

DESCRIPTION="INTRINsec traffic control and advanced routing management console"
HOMEPAGE="http://vulture.open-source.fr"
SRC_URI="http://vulture.open-source.fr/download/VultureNG-${PV}.tar.gz"
S=${WORKDIR}/VultureNG-${PV}
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="apache2 sqlite"

INTRINsec_HOME="/opt/INTRINsec"

RDEPEND="dev-php/sqlite-php
dev-perl/CGI
dev-perl/perl-ldap
dev-perl/Apache-Session
=dev-perl/DBD-SQLite-0.31
dev-perl/DBD-Pg
dev-perl/libwww-perl
net-www/mod_security
>=mod_perl-1.99
>=net-www/apache-2.0.52
dev-php/mod_php
dev-php/PECL-sqlite
app-admin/sudo
net-www/mod_ssl
dev-libs/openssl"

DEPEND="dev-libs/openssl
dev-db/sqlite"

src_unpack() {
	echo "$PWD"
	unpack ${A} || die
}

src_compile() {
	perl -pe 's|/opt/INTRINsec/VultureNG|/opt/INTRINsec/vultureng|g'\
		-i www/WEB-INF/phpmvc-config.xml sql/sqlite.dump
	echo "executing sqlite sql/db < sql/sqlite.dump"
	sqlite sql/db < sql/sqlite.dump
	rm -f lib/Vulture/Makefile
	make OPT=LIB=${D}/usr/lib
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
	insinto /etc/init.d
	insopts -m0750 -o root -g root
	newins ebuild/VultureNG.init vultureng
}

pkg_postinst() {
	openssl req -x509 -newkey rsa:2048 -batch -nodes\
		-config ${INTRINsec_HOME}/${PN}/conf/openssl.cnf\
		-out ${INTRINsec_HOME}/${PN}/conf/vultureng.crt\
		-keyout ${INTRINsec_HOME}/${PN}/conf/vultureng.key
	einfo "Vulture is installed. You can now type the following :"
	einfo "echo \"apache ALL=NOPASSWD:/usr/sbin/apache2,/bin/kill\" >> /etc/sudoers"
}
