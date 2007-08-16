# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/xcache/xcache-1.2.1.ebuild,v 1.2 2007/08/16 09:46:00 jokey Exp $

PHP_EXT_NAME="xcache"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="yes"

inherit php-ext-source-r1 confutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="A fast and stable PHP opcode cacher"
HOMEPAGE="http://xcache.lighttpd.net/"
SRC_URI="http://xcache.lighttpd.net/pub/Releases/${PV}/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
IUSE=""

# make test would just run php's test and as such need the full php source
RESTRICT="test"

DEPEND="!dev-php5/eaccelerator !dev-php5/pecl-apc"
RDEPEND="${DEPEND}"

need_php_by_category

pkg_setup() {
	has_php
	require_php_sapi_from cgi apache2
}

src_compile() {
	has_php

	my_conf="--enable-xcache=shared   \
			--enable-xcache-constant  \
			--enable-xcache-optimizer \
			--enable-xcache-coverager \
			--enable-xcache-assembler \
			--enable-xcache-encoder   \
			--enable-xcache-decoder"

	enable_extension_with_built_with =${PHP_PKG} apache2 apxs2 /usr/sbin/apxs2 "optimisation for apache2"

	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install
	dodoc-php AUTHORS ChangeLog INSTALL COPYING

	php-ext-base-r1_addtoinifiles "auto_globals_jit" '"0"'
	php-ext-base-r1_addtoinifiles "xcache.cacher" '"1"'
	php-ext-base-r1_addtoinifiles "xcache.size" '"10M"'
	php-ext-base-r1_addtoinifiles "xcache.count" '"2"'
	php-ext-base-r1_addtoinifiles "xcache.slots" '"8k"'
	php-ext-base-r1_addtoinifiles "xcache.var_size" '"0"'
	php-ext-base-r1_addtoinifiles "xcache.var_count" '"1"'
	php-ext-base-r1_addtoinifiles "xcache.readonly_protection" '"0"'
	php-ext-base-r1_addtoinifiles "xcache.mmap_path" '"/dev/zero"'
	php-ext-base-r1_addtoinifiles "xcache.stat" '"1"'
	php-ext-base-r1_addtoinifiles "xcache.coverager" '"0"'
	php-ext-base-r1_addtoinifiles "xcache.coveragedump_directory" '""'
	php-ext-base-r1_addtoinifiles "xcache.admin.enable_auth" '"1"'

	dodir "${PHP_EXT_SHARED_DIR}"
	insinto "${PHP_EXT_SHARED_DIR}"
	doins Decompiler.class.php
	dodir "${PHP_EXT_SHARED_DIR}/admin"
	insinto "${PHP_EXT_SHARED_DIR}/admin"
	doins admin/*
}

pkg_postinst() {
	elog "Decompiler.class.php and the admin/ directory shipped with this"
	elog "release were installed into ${ROOT}usr/share/php5/xcache/."
}
