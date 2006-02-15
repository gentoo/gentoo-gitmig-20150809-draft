# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/xdebug/xdebug-2.0.0_beta5.ebuild,v 1.5 2006/02/15 08:30:51 corsair Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="xdebug"

inherit php-ext-source-r1

IUSE=""
DESCRIPTION="A PHP Debugging and Profiling extension."
HOMEPAGE="http://www.xdebug.org/"
SLOT="0"
MY_P="${P/_/}"
SRC_URI="http://pecl.php.net/get/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"
LICENSE="Xdebug"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="${RDEPEND} !dev-php5/ZendOptimizer"

need_php_by_category

src_install() {
	php-ext-source-r1_src_install
	dodoc-php NEWS README Changelog CREDITS LICENSE
}
