# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_mysql/mod_auth_mysql-2.8.1.ebuild,v 1.3 2005/03/25 14:27:41 blubb Exp $

inherit eutils apache-module

DESCRIPTION="Basic authentication for Apache using a MySQL database"
HOMEPAGE="http://modauthmysql.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthmysql/${P}.tar.gz"

DEPEND="dev-db/mysql"
LICENSE="Apache-1.1"
KEYWORDS="~x86 ~amd64"
SLOT="0"

BASE_CONFIG_PVR="2.8.1"

APXS1_ARGS="-c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE1_MOD_CONF="${BASE_CONFIG_PVR}/12_mod_auth_mysql"
APACHE1_MOD_DEFINE="AUTH_MYSQL"

APXS2_ARGS="-c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE2_MOD_CONF="${BASE_CONFIG_PVR}/12_mod_auth_mysql"
APACHE2_MOD_DEFINE="AUTH_MYSQL"

DOCFILES="README"

need_apache
