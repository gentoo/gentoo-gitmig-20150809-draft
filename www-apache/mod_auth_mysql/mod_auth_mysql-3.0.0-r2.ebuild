# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_mysql/mod_auth_mysql-3.0.0-r2.ebuild,v 1.2 2007/09/06 17:27:57 armin76 Exp $

inherit apache-module eutils

DESCRIPTION="Basic authentication for Apache using a MySQL database."
HOMEPAGE="http://modauthmysql.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthmysql/${P}.tar.gz"

LICENSE="Apache-1.1"
KEYWORDS="~amd64 x86"
SLOT="0"
IUSE=""

DEPEND="virtual/mysql
		sys-libs/zlib"
RDEPEND="${DEPEND}"

APXS1_ARGS="-DENABLE=0 -c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE1_MOD_CONF="12_mod_auth_mysql"
APACHE1_MOD_DEFINE="AUTH_MYSQL"

APXS2_ARGS="-c -I/usr/include/mysql -lmysqlclient -lm -lz ${PN}.c"
APACHE2_MOD_CONF="12_mod_auth_mysql"
APACHE2_MOD_DEFINE="AUTH_MYSQL"

DOCFILES="README"

need_apache

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S} -p1" epatch "${FILESDIR}/${P}-apache-2.2.patch"
	EPATCH_OPTS="-d ${S} -p1" epatch "${FILESDIR}/${P}-htpasswd2-auth-style.patch"
}

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
