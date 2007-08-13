# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_cookie_mysql2/mod_auth_cookie_mysql2-0.9a.ebuild,v 1.1 2007/08/13 12:46:27 phreak Exp $

inherit eutils apache-module

KEYWORDS="~x86"

DESCRIPTION="An Apache2 backend authentication module that uses cookies and MySQL."
HOMEPAGE="http://home.digithi.de/digithi/dev/mod_auth_cookie_mysql/"
SRC_URI="http://home.digithi.de/digithi/dev/mod_auth_cookie_mysql/${P/-/_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/mysql"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/-/_}"

APXS2_ARGS="-I/usr/include/mysql -lmysqlclient -lz -c ${PN}.c"

APACHE2_MOD_CONF="55_${PN}"
APACHE2_MOD_DEFINE="AUTH_COOKIE_MYSQL2"

DOCFILES="README mod_auth_cookie_mysql.html"

need_apache2

pkg_postinst() {
	ewarn
	ewarn "There are a number of variables that need to be configured before"
	ewarn "MOD_AUTH_COOKIE_MYSQL2 can work. After this package has finished"
	ewarn "building, please go and modify the configuration file located at"
	ewarn "${APACHE2_MODULES_CONFDIR}/$(basename ${APACHE2_MOD_CONF}).conf"
	ewarn
	ebeep 5
	apache-module_pkg_postinst
}
