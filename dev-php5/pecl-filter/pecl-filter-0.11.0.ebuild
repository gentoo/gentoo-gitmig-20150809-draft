# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-filter/pecl-filter-0.11.0.ebuild,v 1.11 2007/04/01 08:25:54 vapier Exp $

PHP_EXT_NAME="filter"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

DESCRIPTION="Extension for safely dealing with input parameters."

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="!>=dev-lang/php-5.2"
RDEPEND="${DEPEND}"

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use pcre
}

src_install() {
	php-ext-pecl-r1_src_install
	php-ext-base-r1_addtoinifiles "filter.default" '"unsafe_raw"'
}
