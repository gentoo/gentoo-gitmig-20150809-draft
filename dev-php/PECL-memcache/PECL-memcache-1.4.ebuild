# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-memcache/PECL-memcache-1.4.ebuild,v 1.1 2005/07/02 07:59:55 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="memcache"
PHP_EXT_NAME="memcache"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="PHP extension for using memcached."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86"
