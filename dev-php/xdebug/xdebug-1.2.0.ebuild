# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug/xdebug-1.2.0.ebuild,v 1.1 2003/05/16 12:25:44 coredumb Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="xdebug"

inherit php-ext

IUSE=""
DESCRIPTION="A PHP debugger"
HOMEPAGE="http://xdebug.derickrethans.nl"
SLOT="0"
SRC_URI="files.derickrethans.nl/xdebug-1.2.0.tgz"
S=${WORKDIR}/${P}
LICENSE="PHP"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

src_install() {
php-ext_src_install
dodoc NEWS README Changelog CREDITS
}
