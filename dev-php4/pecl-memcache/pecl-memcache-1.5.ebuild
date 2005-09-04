# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-memcache/pecl-memcache-1.5.ebuild,v 1.1 2005/09/04 15:40:08 stuart Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="memcache"
PHP_EXT_NAME="memcache"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="PHP extension for using memcached."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~ppc ~x86"

DEPEND="${DEPEND}
		sys-libs/zlib"

need_php_by_category

src_compile() {
	has_php
	my_conf="--enable-memcache --with-zlib-dir=/usr"
	php-ext-pecl-r1_src_compile
}
