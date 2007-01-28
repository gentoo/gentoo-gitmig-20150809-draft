# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty/smarty-2.6.16.ebuild,v 1.2 2007/01/28 06:27:38 genone Exp $

inherit php-lib-r1

DESCRIPTION="A template engine for PHP."
HOMEPAGE="http://smarty.php.net/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND="doc? ( dev-php/smarty-docs )"

MY_P="Smarty-${PV}"
SRC_URI="http://smarty.php.net/distributions/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

need_php_by_category

src_install() {
	dodoc-php BUGS ChangeLog FAQ NEWS QUICK_START README RELEASE_NOTES TODO
	php-lib-r1_src_install ./libs `find ./libs -type f -print | sed -e "s|./libs||g"`
}

pkg_postinst() {
	elog "${PHP_LIB_NAME} has been installed in /usr/share/php/${PHP_LIB_NAME}/."
	elog "To use it in your scripts, either"
	elog "1. define('SMARTY_DIR', \"/usr/share/php/${PHP_LIB_NAME}/\") in your scripts, or"
	elog "2. add '/usr/share/php/${PHP_LIB_NAME}/' to the 'include_path' variable in your"
	elog "php.ini file under /etc/php/SAPI (where SAPI is one of apache-php[45],"
	elog "cgi-php[45] or cli-php[45])."
	elog
	elog "If you're upgrading from a previous version make sure to clear out your"
	elog "templates_c and cache directories as some include paths have changed!"
	elog
	elog "The Smarty include directory has changed in 2.6.12 from /usr/share/php/Smarty/"
	elog "to /usr/share/php/${PHP_LIB_NAME}/ you will need to change your SMARTY_DIR or"
	elog "include_path accordingly."
}
