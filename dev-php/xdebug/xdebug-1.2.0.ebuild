# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug/xdebug-1.2.0.ebuild,v 1.6 2004/04/17 15:02:29 aliz Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="xdebug"

inherit php-ext-source

IUSE=""
DESCRIPTION="A PHP debugger"
HOMEPAGE="http://xdebug.derickrethans.nl"
SLOT="0"
SRC_URI="http://files.derickrethans.nl/${P}.tgz"
LICENSE="PHP"
KEYWORDS="x86 ~ppc ~alpha ~sparc"

src_install() {
php-ext-source_src_install
dodoc NEWS README Changelog CREDITS
}
