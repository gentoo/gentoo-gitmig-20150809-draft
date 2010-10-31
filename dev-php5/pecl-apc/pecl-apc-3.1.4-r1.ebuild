# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-apc/pecl-apc-3.1.4-r1.ebuild,v 1.2 2010/10/31 23:53:12 mabi Exp $

EAPI=2

PHP_EXT_NAME="apc"
PHP_EXT_PECL_PKG="APC"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CHANGELOG INSTALL NOTICE TECHNOTES.txt TODO"

inherit php-ext-pecl-r2 confutils eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="A free, open, and robust framework for caching and optimizing PHP code."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="mmap"

DEPEND="!dev-php5/eaccelerator !dev-php5/xcache
		|| ( dev-lang/php[apache2] dev-lang/php[cgi] dev-lang/php[fpm] )"
RDEPEND="${DEPEND}"

src_compile() {
	my_conf="--enable-apc"
	enable_extension_enable "apc-mmap" "mmap" 0

	php-ext-pecl-r2_src_compile
}

src_install() {
	php-ext-pecl-r2_src_install

	php-ext-source-r2_addtoinifiles "apc.enabled" '"1"'
	php-ext-source-r2_addtoinifiles "apc.shm_segments" '"1"'
	php-ext-source-r2_addtoinifiles "apc.shm_size" '"30M"'
	php-ext-source-r2_addtoinifiles "apc.num_files_hint" '"1024"'
	php-ext-source-r2_addtoinifiles "apc.ttl" '"7200"'
	php-ext-source-r2_addtoinifiles "apc.user_ttl" '"7200"'
	php-ext-source-r2_addtoinifiles "apc.gc_ttl" '"3600"'
	php-ext-source-r2_addtoinifiles "apc.cache_by_default" '"1"'
	php-ext-source-r2_addtoinifiles ";apc.filters" '""'
	php-ext-source-r2_addtoinifiles ";apc.mmap_file_mask" '"/tmp/apcphp5.XXXXXX"'
	php-ext-source-r2_addtoinifiles "apc.slam_defense" '"0"'
	php-ext-source-r2_addtoinifiles "apc.file_update_protection" '"2"'
	php-ext-source-r2_addtoinifiles "apc.enable_cli" '"0"'
	php-ext-source-r2_addtoinifiles "apc.max_file_size" '"1M"'
	php-ext-source-r2_addtoinifiles "apc.stat" '"1"'
	php-ext-source-r2_addtoinifiles "apc.write_lock" '"1"'
	php-ext-source-r2_addtoinifiles "apc.report_autofilter" '"0"'
	php-ext-source-r2_addtoinifiles "apc.include_once_override" '"0"'
	php-ext-source-r2_addtoinifiles "apc.rfc1867" '"0"'
	php-ext-source-r2_addtoinifiles "apc.rfc1867_prefix" '"upload_"'
	php-ext-source-r2_addtoinifiles "apc.rfc1867_name" '"APC_UPLOAD_PROGRESS"'
	php-ext-source-r2_addtoinifiles "apc.rfc1867_freq" '"0"'
	php-ext-source-r2_addtoinifiles "apc.localcache" '"0"'
	php-ext-source-r2_addtoinifiles "apc.localcache.size" '"512"'
	php-ext-source-r2_addtoinifiles "apc.coredump_unmap" '"0"'

	dodir "${PHP_EXT_SHARED_DIR}"
	insinto "${PHP_EXT_SHARED_DIR}"
	doins apc.php
}

pkg_postinst() {
	elog "The apc.php file shipped with this release of PECL-APC was"
	elog "installed into ${PHP_EXT_SHARED_DIR}/apc/."
}
