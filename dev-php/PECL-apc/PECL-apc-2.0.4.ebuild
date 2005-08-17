# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-apc/PECL-apc-2.0.4.ebuild,v 1.6 2005/08/17 08:01:04 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="APC"
PHP_EXT_NAME="apc"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="The Alternative PHP Cache"
SLOT="0"
LICENSE="PHP"
KEYWORDS="alpha amd64 ppc ~sparc x86"
DEPEND="${DEPEND}
	!dev-php/eaccelerator
	!dev-php/ioncube_loaders
	=dev-php/php-4*"

src_install () {
	php-ext-pecl_src_install
	dodoc CHANGELOG INSTALL LICENSE NOTICE

	php-ext-base_addtoinifiles "apc.enabled" '"1"'
	php-ext-base_addtoinifiles "apc.shm_segments" '"1"'
	php-ext-base_addtoinifiles "apc.shm_size" '"30"'
	php-ext-base_addtoinifiles "apc.optimization" '"0"'
	php-ext-base_addtoinifiles "apc.num_files_hint" '"1000"'
	php-ext-base_addtoinifiles "apc.gc_ttl" '"3600"'
	php-ext-base_addtoinifiles "apc.filters" '""'
}
