# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug/xdebug-1.3.0.ebuild,v 1.6 2004/11/29 12:40:30 blubb Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="xdebug"

inherit php-ext-source

IUSE=""
DESCRIPTION="A PHP debugger"
HOMEPAGE="http://xdebug.derickrethans.nl"
SLOT="0"
MY_P="${P/_/}"
SRC_URI="http://files.derickrethans.nl/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"
LICENSE="Xdebug"
KEYWORDS="x86 alpha ~sparc ppc ~amd64"

src_install() {
php-ext-source_src_install
dodoc NEWS README Changelog CREDITS LICENSE
}
