# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_mysql/mod_auth_mysql-3.0.0-r1.ebuild,v 1.1 2006/06/05 19:14:14 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Basic authentication for Apache using a MySQL database"
HOMEPAGE="http://modauthmysql.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthmysql/${P}.tar.gz"

DEPEND="dev-db/mysql"
LICENSE="Apache-1.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"

BASE_CONFIG_PVR="2.8.1"

APXS1_ARGS="-DENABLE=0 -c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE1_MOD_CONF="${BASE_CONFIG_PVR}/12_mod_auth_mysql"
APACHE1_MOD_DEFINE="AUTH_MYSQL"

APXS2_ARGS="-c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE2_MOD_CONF="${BASE_CONFIG_PVR}/12_mod_auth_mysql"
APACHE2_MOD_DEFINE="AUTH_MYSQL"

DOCFILES="README"

need_apache

pkg_postinst() {
	if ! useq apache2; then
		ewarn "With regard to bug #132391 the behaviour of mod_auth_mysql"
		ewarn "has changed for apache-1.3.x"
		ewarn
		ewarn "You need to enable mod_auth_ldap in your .htaccess files"
		ewarn "explicitely using:"
		ewarn
		ewarn "  AuthMySQLEnable On"
		ewarn
	fi
}
