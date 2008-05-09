# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-apc/pecl-apc-3.0.16-r1.ebuild,v 1.6 2008/05/09 12:48:11 hoffie Exp $

PHP_EXT_NAME="apc"
PHP_EXT_PECL_PKG="APC"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CHANGELOG INSTALL NOTICE TECHNOTES.txt TODO"

inherit php-ext-pecl-r1 confutils eutils

KEYWORDS="amd64 ppc ~ppc64 sparc x86"

DESCRIPTION="A free, open, and robust framework for caching and optimizing PHP code."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="mmap"

DEPEND="!dev-php5/eaccelerator !dev-php5/xcache"
RDEPEND="${DEPEND}"

need_php_by_category

pkg_setup() {
	has_php
	require_php_sapi_from cgi apache2
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch for CVE-2008-1488, Bug 214576
	epatch "${FILESDIR}"/${P}-CVE-2008-1488.patch
	# http://pecl.php.net/bugs/bug.php?id=12777, Bug 204224
	epatch "${FILESDIR}"/${P}-apc_set_signals.patch

	php-ext-source-r1_phpize
}

src_compile() {
	has_php

	my_conf="--enable-apc"
	enable_extension_enable "apc-mmap" "mmap" 0
	enable_extension_with_built_with =${PHP_PKG} apache2 apxs /usr/sbin/apxs2 "optimisation for apache2"

	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install

	php-ext-base-r1_addtoinifiles "apc.enabled" '"1"'
	php-ext-base-r1_addtoinifiles "apc.shm_segments" '"1"'
	php-ext-base-r1_addtoinifiles "apc.shm_size" '"30"'
	php-ext-base-r1_addtoinifiles "apc.optimization" '"0"'
	php-ext-base-r1_addtoinifiles "apc.num_files_hint" '"1024"'
	php-ext-base-r1_addtoinifiles "apc.ttl" '"7200"'
	php-ext-base-r1_addtoinifiles "apc.user_ttl" '"7200"'
	php-ext-base-r1_addtoinifiles "apc.gc_ttl" '"3600"'
	php-ext-base-r1_addtoinifiles "apc.cache_by_default" '"1"'
	php-ext-base-r1_addtoinifiles ";apc.mmap_file_mask" '"/tmp/apcphp5.XXXXXX"'
	php-ext-base-r1_addtoinifiles "apc.file_update_protection" '"2"'
	php-ext-base-r1_addtoinifiles "apc.enable_cli" '"0"'
	php-ext-base-r1_addtoinifiles "apc.max_file_size" '"1M"'
	php-ext-base-r1_addtoinifiles "apc.stat" '"1"'
	php-ext-base-r1_addtoinifiles "apc.write_lock" '"1"'

	dodir "${PHP_EXT_SHARED_DIR}"
	insinto "${PHP_EXT_SHARED_DIR}"
	doins apc.php
}

pkg_postinst() {
	elog "The apc.php file shipped with this release of PECL-APC was"
	elog "installed into ${ROOT}usr/share/php5/apc/."
}
