# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug/xdebug-2.0.0_beta2.ebuild,v 1.1 2005/03/15 10:16:58 sebastian Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_PECL_PKG="xdebug"
PHP_EXT_NAME="xdebug"
PHP_EXT_INI="yes"
PHP_EXT_PECL_FILENAME=""

inherit php-ext-pecl

IUSE=""
DESCRIPTION="A PHP Debugging and Profiling extension."
HOMEPAGE="http://www.xdebug.org/"
MY_P="${P/_/}"
SRC_URI="http://www.xdebug.org/files/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"
SLOT="0"
LICENSE="Xdebug"
KEYWORDS="~x86"
