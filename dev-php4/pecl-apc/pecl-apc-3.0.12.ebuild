# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-apc/pecl-apc-3.0.12.ebuild,v 1.2 2006/09/05 04:07:27 sebastian Exp $

PHP_EXT_NAME="apc"
PHP_EXT_PECL_PKG="APC"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1 confutils

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="A free, open, and robust framework for caching and optimizing PHP intermediate code."
LICENSE="PHP"
SLOT="0"
IUSE="mmap"

DEPEND="${DEPEND}
		!dev-php4/eaccelerator"

need_php_by_category

pkg_setup() {
	has_php

	require_php_sapi_from cgi apache apache2
}

src_compile() {
	has_php

	# PECL-APC does not work with Zend Thread Safety (ZTS)
	# so abort if we are using PHP compiled with ZTS.
	if has_zts ; then
		eerror "PECL-APC doesn't work with a ZTS enabled PHP."
		eerror "Please disable ZTS by turning the 'threads'"
		eerror "USE flag off when you compile dev-lang/php."
		die "PECL-APC does not support ZTS"
	fi

	my_conf="--enable-apc"
	enable_extension_enable "apc-mmap" "mmap" 0
	enable_extension_with_built_with =${PHP_PKG} apache2 apxs2 /usr/sbin/apxs2 "optimisation for apache2"
	enable_extension_with_built_with =${PHP_PKG} apache apxs /usr/sbin/apxs "optimisation for apache1"

	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install
	dodoc-php CHANGELOG INSTALL LICENSE NOTICE

	php-ext-base-r1_addtoinifiles "apc.enabled" '"1"'
	php-ext-base-r1_addtoinifiles "apc.shm_segments" '"1"'
	php-ext-base-r1_addtoinifiles "apc.shm_size" '"30"'
	php-ext-base-r1_addtoinifiles "apc.optimization" '"0"'
	php-ext-base-r1_addtoinifiles "apc.num_files_hint" '"1000"'
	php-ext-base-r1_addtoinifiles "apc.ttl" '"0"'
	php-ext-base-r1_addtoinifiles "apc.gc_ttl" '"3600"'
	php-ext-base-r1_addtoinifiles "apc.cache_by_default" '"1"'
	php-ext-base-r1_addtoinifiles "apc.filters" '""'
	php-ext-base-r1_addtoinifiles "apc.mmap_file_mask" '""'
	php-ext-base-r1_addtoinifiles "apc.slam_defense" '"0"'
	php-ext-base-r1_addtoinifiles "apc.file_update_protection" '"2"'
	php-ext-base-r1_addtoinifiles "apc.stat" '"1"'
	php-ext-base-r1_addtoinifiles "apc.include_once_override" '"0"'

	dodir "${PHP_EXT_SHARED_DIR}"
	insinto "${PHP_EXT_SHARED_DIR}"
	doins apc.php
}

pkg_postinst() {
	einfo "The apc.php file shipped with this release of PECL-APC was"
	einfo "installed into /usr/share/php4/apc/."
}
