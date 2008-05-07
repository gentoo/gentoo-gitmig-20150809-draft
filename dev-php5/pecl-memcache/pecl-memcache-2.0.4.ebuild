# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-memcache/pecl-memcache-2.0.4.ebuild,v 1.4 2008/05/07 16:42:57 hoffie Exp $

PHP_EXT_NAME="memcache"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 hppa ~ppc ~ppc64 sparc ~x86"

DESCRIPTION="PHP extension for using memcached."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

need_php_by_category

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix bug #117990 better, without using a patch
	# upstream has the file with CRLF instead of LF
	edos2unix "${S}/config.m4"

	php-ext-source-r1_src_unpack
}

src_compile() {
	my_conf="--enable-memcache --with-zlib-dir=/usr"
	php-ext-pecl-r1_src_compile
}
