# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-memcache/pecl-memcache-2.0.1.ebuild,v 1.3 2006/05/03 13:09:58 gustavoz Exp $

PHP_EXT_NAME="memcache"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="hppa ~ppc ~ppc64 sparc ~x86 ~amd64"
DESCRIPTION="PHP extension for using memcached."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		sys-libs/zlib"

need_php_by_category

src_unpack() {
	unpack ${A}

	cd "${S}"

	# fix bug #117990 better, without using a patch
	# upstream has the file with CRLF instead of LF
	edos2unix "${S}/config.m4"
}

src_compile() {
	has_php

	my_conf="--enable-memcache --with-zlib-dir=/usr"
	php-ext-pecl-r1_src_compile
}
