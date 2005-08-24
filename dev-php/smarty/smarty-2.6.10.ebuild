# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty/smarty-2.6.10.ebuild,v 1.2 2005/08/24 00:15:42 tomk Exp $

MY_P=Smarty-${PV}
DESCRIPTION="A template engine for PHP"
HOMEPAGE="http://smarty.php.net/"
SRC_URI="http://smarty.php.net/distributions/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~hppa ~ppc ~sparc ~x86 ~amd64"
IUSE="doc"
DEPEND="doc? ( dev-php/smarty-docs )"
RDEPEND="virtual/php"
S=${WORKDIR}/${MY_P}

src_install() {
	dodoc [A-Z]*
	mkdir -p ${D}/usr/lib/php
	cp -pPR libs ${D}/usr/lib/php/Smarty
}

pkg_postinst() {
	einfo "Smarty has been installed in /usr/lib/php/Smarty/."
	einfo "To use it in your scripts, either"
	einfo "1. define('SMARTY_DIR', \"/usr/lib/php/Smarty/\") in your scripts, or"
	einfo "2. add '/usr/lib/php/Smarty/' to the 'include_path' variable in your"
	einfo "php.ini file under /etc/php/SAPI (where SAPI is one of apache-php[45],"
	einfo "cgi-php[45] or cli-php[45])."
	echo
	einfo "If you're upgrading from version < 2.6.6 make sure to clear out your"
	einfo "templates_c and cache directories as some include paths have changed."
}
