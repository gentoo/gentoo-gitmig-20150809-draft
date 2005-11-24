# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty/smarty-2.6.10-r1.ebuild,v 1.1 2005/11/24 12:26:46 chtekk Exp $

PHP_LIB_NAME="Smarty"

inherit php-lib-r1

DESCRIPTION="A template engine for PHP."
HOMEPAGE="http://smarty.php.net/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="doc? ( dev-php/smarty-docs )"

MY_P="${PHP_LIB_NAME}-${PV}"
SRC_URI="http://smarty.php.net/distributions/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

need_php_by_category

src_install() {
	dodoc-php [A-Z]*
	php-lib-r1_src_install ./libs `find ./libs -type f -print | sed -e "s|./libs||g"`
}

pkg_postinst() {
	einfo "${PHP_LIB_NAME} has been installed in /usr/share/php/Smarty/."
	einfo "To use it in your scripts, either"
	einfo "1. define('SMARTY_DIR', \"/usr/share/php/Smarty/\") in your scripts, or"
	einfo "2. add '/usr/share/php/Smarty/' to the 'include_path' variable in your"
	einfo "php.ini file under /etc/php/SAPI (where SAPI is one of apache-php[45],"
	einfo "cgi-php[45] or cli-php[45])."
	echo
	einfo "If you're upgrading from a version < 2.6.6 make sure to clear out your"
	einfo "templates_c and cache directories as some include paths have changed!"
}
