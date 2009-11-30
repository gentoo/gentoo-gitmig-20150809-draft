# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-memcached/pecl-memcached-1.0.0.ebuild,v 1.1 2009/11/30 07:55:11 robbat2 Exp $

EAPI="1"
PHP_EXT_NAME="memcached"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

inherit php-ext-pecl-r1 php-ext-base-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension for interfacing with memcached via libmemcached library"
LICENSE="PHP-3"
SLOT="0"
IUSE="+session"

DEPEND="dev-libs/libmemcached sys-libs/zlib"
RDEPEND="${DEPEND}"

need_php_by_category

pkg_setup() {
	use session && require_php_with_use session
}

src_compile() {
	my_conf="--enable-memcached
		--with-zlib-dir=/usr
		$(use_enable session memcached-session)"
	#--enable-memcached-igbinary
	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install

	#php-ext-base-r1_addtoinifiles "memcached...." "..."
}
