# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-memcache/pecl-memcache-2.1.2.ebuild,v 1.1 2007/08/20 21:15:00 jokey Exp $

PHP_EXT_NAME="memcache"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="PHP extension for using memcached."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	my_conf="--enable-memcache --with-zlib-dir=/usr"
	php-ext-pecl-r1_src_compile
}
