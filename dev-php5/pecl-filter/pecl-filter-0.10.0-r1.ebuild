# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-filter/pecl-filter-0.10.0-r1.ebuild,v 1.2 2006/11/25 22:28:27 kloeri Exp $

PHP_EXT_NAME="filter"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="Extension for safely dealing with input parameters."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="dev-libs/libpcre"
RDEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	has_php

	my_conf="--enable-filter --with-pcre-dir=/usr"

	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install

	php-ext-base-r1_addtoinifiles "filter.default" '"unsafe_raw"'
}
