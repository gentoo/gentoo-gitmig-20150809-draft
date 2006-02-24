# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdo/pecl-pdo-1.0.2.ebuild,v 1.11 2006/02/24 14:16:32 jer Exp $

PHP_EXT_NAME="pdo"
PHP_EXT_PECL_PKG="PDO"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
DESCRIPTION="Core PHP Data Objects (PDO)."
LICENSE="PHP"
SLOT="0"
IUSE="mssql mysql oci8 oci8-instant-client odbc postgres sqlite"

PDEPEND="${PDEPEND}
		mssql? ( dev-php5/pecl-pdo-dblib )
		mysql? ( dev-php5/pecl-pdo-mysql )
		oci8? ( dev-php5/pecl-pdo-oci )
		oci8-instant-client? ( dev-php5/pecl-pdo-oci )
		odbc? ( dev-php5/pecl-pdo-odbc )
		postgres? ( dev-php5/pecl-pdo-pgsql )
		sqlite? ( dev-php5/pecl-pdo-sqlite )"

need_php_by_category

pkg_setup() {
	has_php

	# if the user has compiled in PDO, he can't use this package
	if built_with_use =${PHP_PKG} pdo ; then
		eerror
		eerror "You have built ${PHP_PKG} to use the bundled PDO support."
		eerror "If you want to use the PECL PDO packages, you must rebuild"
		eerror "your PHP with the 'pdo-external' USE flag instead."
		eerror
		die "PHP built to use bundled PDO support"
	fi
}

src_install() {
	php-ext-pecl-r1_src_install

	# install missing header files
	# usually done by "make install"
	destdir=/usr/$(get_libdir)/php5
	dodir "${destdir}/include/php/ext/pdo"
	insinto "${destdir}/include/php/ext/pdo"
	doins php_pdo_driver.h
	doins php_pdo.h
}
