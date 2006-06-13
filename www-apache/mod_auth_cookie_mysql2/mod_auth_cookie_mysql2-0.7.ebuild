# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_cookie_mysql2/mod_auth_cookie_mysql2-0.7.ebuild,v 1.1 2006/06/13 16:31:01 chtekk Exp $

inherit eutils apache-module

KEYWORDS="~x86"
DESCRIPTION="An Apache2 backend authentication module that uses Cookies and MySQL."
HOMEPAGE="http://home.digithi.de/digithi/dev/mod_auth_cookie_mysql/"
SRC_URI="http://home.digithi.de/digithi/dev/mod_auth_cookie_mysql/${P/-/_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-db/mysql"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/-/_}"

APXS2_ARGS="-lmysqlclient -lz -I/usr/include/mysql -L/usr/lib/mysql -c ${PN}.c"

APACHE2_MOD_CONF="55_${PN}"
APACHE2_MOD_DEFINE="AUTH_COOKIE_MYSQL2"

DOCFILES="README mod_auth_cookie_mysql.html"

need_apache2

pkg_postinst() {
	ewarn
	ewarn "There are a number of variables that need to be configured before"
	ewarn "MOD_AUTH_COOKIE_MYSQL2 can work. After this package has finished"
	ewarn "building, please go and modify the conf file located in"
	ewarn "${APACHE2_MODULES_CONFDIR}/$(basename ${APACHE2_MOD_CONF}).conf"
	ewarn
	ebeep 5
	apache-module_pkg_postinst
}
