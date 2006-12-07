# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_mysql/mod_auth_mysql-3.0.0-r1.ebuild,v 1.3 2006/12/07 16:36:01 chtekk Exp $

inherit apache-module

KEYWORDS="amd64 x86"

DESCRIPTION="Basic authentication for Apache using a MySQL database."
HOMEPAGE="http://modauthmysql.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthmysql/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"

DEPEND="virtual/mysql
		sys-libs/zlib"
RDEPEND="${DEPEND}"

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
	if ! useq apache2 ; then
		elog "With regard to bug #132391 the behaviour of ${PN}"
		elog "has changed for Apache-1.3.XX."
		elog
		elog "You now need to enable ${PN} in your .htaccess"
		elog "files explicitely using:"
		elog
		elog "  AuthMySQLEnable On"
	fi
}
