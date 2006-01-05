# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-memcache/pecl-memcache-2.0.0.ebuild,v 1.1 2006/01/05 17:07:09 sebastian Exp $

PHP_EXT_NAME="memcache"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="PHP extension for using memcached."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		sys-libs/zlib"

need_php_by_category

src_compile() {
	has_php

	my_conf="--enable-memcache --with-zlib-dir=/usr"
	php-ext-pecl-r1_src_compile
}
