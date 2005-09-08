# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-memcache/PECL-memcache-1.4.ebuild,v 1.3 2005/09/08 15:26:33 blubb Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="memcache"
PHP_EXT_NAME="memcache"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="PHP extension for using memcached."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~amd64 x86"
