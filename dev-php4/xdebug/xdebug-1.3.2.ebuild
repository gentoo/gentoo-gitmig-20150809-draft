# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/xdebug/xdebug-1.3.2.ebuild,v 1.3 2005/11/19 20:53:36 corsair Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="xdebug"

inherit php-ext-source-r1

IUSE=""
DESCRIPTION="A PHP Debugging and Profiling extension."
HOMEPAGE="http://www.xdebug.org/"
SLOT="0"
MY_P="${P/_/}"
SRC_URI="http://www.xdebug.org/files/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"
LICENSE="Xdebug"
KEYWORDS="~ppc ~ppc64 ~sparc ~x86"

need_php_by_category

src_install() {
	php-ext-source-r1_src_install
	dodoc NEWS README Changelog CREDITS LICENSE
}
