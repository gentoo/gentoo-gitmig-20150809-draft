# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug/xdebug-1.2.0.ebuild,v 1.3 2003/07/20 17:56:24 coredumb Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="xdebug"

inherit php-ext

IUSE=""
DESCRIPTION="A PHP debugger"
HOMEPAGE="http://xdebug.derickrethans.nl"
SLOT="0"
SRC_URI="http://files.derickrethans.nl/${P}.tgz"
S=${WORKDIR}/${P}
LICENSE="PHP"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

src_install() {
php-ext_src_install
dodoc NEWS README Changelog CREDITS
}
