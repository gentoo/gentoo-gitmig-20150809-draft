# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_mysql/mod_auth_mysql-3.0.0-r2.ebuild,v 1.5 2007/11/25 14:59:05 hollow Exp $

inherit apache-module eutils

DESCRIPTION="Basic authentication for Apache using a MySQL database."
HOMEPAGE="http://modauthmysql.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthmysql/${P}.tar.gz"

LICENSE="Apache-1.1"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

DEPEND="virtual/mysql
		sys-libs/zlib"
RDEPEND="${DEPEND}"

APXS2_ARGS="-c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE2_MOD_CONF="12_${PN}"
APACHE2_MOD_DEFINE="AUTH_MYSQL"

DOCFILES="README CONFIGURE"

need_apache2_2

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S} -p1" epatch "${FILESDIR}/${P}-apache-2.2.patch"
	EPATCH_OPTS="-d ${S} -p1" epatch "${FILESDIR}/${P}-htpasswd2-auth-style.patch"
}
