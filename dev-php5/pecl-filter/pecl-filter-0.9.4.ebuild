# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-filter/pecl-filter-0.9.4.ebuild,v 1.5 2006/08/24 02:12:10 weeve Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="filter"
PHP_EXT_NAME="filter"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1 confutils

DESCRIPTION="Extension for safely dealing with input parameters."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

need_php_by_category

src_compile() {
	has_php

	my_conf="--enable-filter"
	php-ext-pecl-r1_src_compile
}
