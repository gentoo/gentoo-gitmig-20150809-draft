# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug/xdebug-1.3.2.ebuild,v 1.1 2005/02/14 08:14:34 sebastian Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="xdebug"

inherit php-ext-source

IUSE=""
DESCRIPTION="A PHP Debugging and Profiling extension."
HOMEPAGE="http://www.xdebug.org/"
SLOT="0"
MY_P="${P/_/}"
SRC_URI="http://www.xdebug.org/files/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"
LICENSE="Xdebug"
KEYWORDS="~x86 ~alpha ~sparc ~ppc ~amd64"

src_install() {
	php-ext-source_src_install
	dodoc NEWS README Changelog CREDITS LICENSE
}
