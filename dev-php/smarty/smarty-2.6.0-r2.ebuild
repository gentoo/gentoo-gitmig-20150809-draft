# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty/smarty-2.6.0-r2.ebuild,v 1.2 2004/01/08 08:39:49 robbat2 Exp $

MY_P=Smarty-${PV}
DESCRIPTION="A template engine for PHP"
HOMEPAGE="http://smarty.php.net/"
SRC_URI="http://smarty.php.net/distributions/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha  hppa  ppc sparc x86"
IUSE="doc"
DEPEND=""
RDEPEND="virtual/php"
S=${WORKDIR}/${MY_P}

src_install() {
	dodoc [A-Z]*
	mkdir -p ${D}/usr/lib/php
	cp -a libs ${D}/usr/lib/php/Smarty
}

pkg_postinst() {
	einfo "Smarty has been installed in /usr/lib/php/Smarty/."
	einfo "To use it in your scripts, either"
	einfo "1. define('SMARTY_DIR', \"/usr/lib/php/Smarty/\") in your scripts, or"
	einfo "2. add /usr/lib/php/Smarty/ to includes= in /etc/php4/php.ini"
}
