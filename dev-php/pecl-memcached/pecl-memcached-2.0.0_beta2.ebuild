# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-memcached/pecl-memcached-2.0.0_beta2.ebuild,v 1.2 2012/01/15 17:02:15 olemarkus Exp $

EAPI="2"
PHP_EXT_NAME="memcached"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

MY_PV="2.0.0b2"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension for interfacing with memcached via libmemcached library"
LICENSE="PHP-3"
SLOT="0"
IUSE="+session igbinary"

DEPEND=">=dev-libs/libmemcached-0.38 sys-libs/zlib
		dev-lang/php[session?]
		igbinary? ( dev-php/igbinary[php_targets_php5-3?,php_targets_php5-2?] )"
RDEPEND="${DEPEND}"

src_configure() {
	my_conf="--enable-memcached
		--with-zlib-dir=/usr
		$(use_enable session memcached-session)
		$(use_enable igbinary memcached-igbinary)"

	php-ext-source-r2_src_configure
}
