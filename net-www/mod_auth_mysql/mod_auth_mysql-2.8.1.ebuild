# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_mysql/mod_auth_mysql-2.8.1.ebuild,v 1.1 2005/01/22 04:12:46 trapni Exp $

inherit eutils apache-module

DESCRIPTION="Basic authentication for Apache using a MySQL database"
HOMEPAGE="http://modauthmysql.sourceforge.net/"

SRC_URI="mirror://sourceforge/modauthmysql/${P}.tar.gz"
DEPEND="dev-db/mysql"
RDEPEND=""
LICENSE="Apache-1.1"
KEYWORDS="~x86"
SLOT="0"

BASE_CONFIG_PVR="2.8.1"

# Dual Apache
DOCFILES="README"

# Apache 2.0
APXS2_S="${S}"
APXS2_ARGS="-c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE2_MOD_CONF="${BASE_CONFIG_PVR}/12_mod_auth_mysql"
APACHE2_MOD_DEFINE="AUTH_MYSQL"

# Apache 1.x
APXS1_S="${S}"
APXS1_ARGS="-c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE1_MOD_CONF="${BASE_CONFIG_PVR}/12_mod_auth_mysql"
APACHE1_MOD_DEFINE="AUTH_MYSQL"

need_apache
