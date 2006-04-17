# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty/smarty-2.6.13.ebuild,v 1.2 2006/04/17 22:15:53 halcy0n Exp $

inherit php-lib-r1

DESCRIPTION="A template engine for PHP."
HOMEPAGE="http://smarty.php.net/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND="doc? ( dev-php/smarty-docs )"

MY_P="Smarty-${PV}"
SRC_URI="http://smarty.php.net/distributions/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

need_php_by_category

src_install() {
	dodoc-php [A-Z]*
	php-lib-r1_src_install ./libs `find ./libs -type f -print | sed -e "s|./libs||g"`
}

pkg_postinst() {
	einfo "${PHP_LIB_NAME} has been installed in /usr/share/php/${PHP_LIB_NAME}/."
	einfo "To use it in your scripts, either"
	einfo "1. define('SMARTY_DIR', \"/usr/share/php/${PHP_LIB_NAME}/\") in your scripts, or"
	einfo "2. add '/usr/share/php/${PHP_LIB_NAME}/' to the 'include_path' variable in your"
	einfo "php.ini file under /etc/php/SAPI (where SAPI is one of apache-php[45],"
	einfo "cgi-php[45] or cli-php[45])."
	echo
	einfo "If you're upgrading from a previous version make sure to clear out your"
	einfo "templates_c and cache directories as some include paths have changed!"
	echo
	einfo "The Smarty include directory has changed in 2.6.12 from /usr/share/php/Smarty/"
	einfo "to /usr/share/php/${PHP_LIB_NAME}/ you will need to change your SMARTY_DIR or"
	einfo "include_path accordingly."
}
