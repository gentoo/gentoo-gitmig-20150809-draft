# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdo/pecl-pdo-0.9.ebuild,v 1.7 2005/11/11 02:14:03 vapier Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="PDO"
PHP_EXT_NAME="pdo"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE="firebird mssql mysql oci8 odbc postgres sqlite"
DESCRIPTION="Core PHP Data Objects (PDO)"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~s390 ~sparc ~x86"
PDEPEND="${PDEPEND}
		firebird? ( dev-php5/pecl-pdo-firebird )
		mssql? ( dev-php5/pecl-pdo-dblib )
		mysql? ( dev-php5/pecl-pdo-mysql )
		oci8? ( dev-php5/pecl-pdo-oci )
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

src_unpack() {
	unpack ${A}

	cd ${S}

	# Patches the file to the newest CVS sources
	epatch ${FILESDIR}/pdo_stmt.c.diff
}

src_install() {
	php-ext-pecl-r1_src_install

	# install missing header files
	destdir=/usr/$(get_libdir)/php5
	dodir ${destdir}/include/php/ext/pdo
	insinto ${destdir}/include/php/ext/pdo
	doins php_pdo_driver.h
	doins php_pdo.h
	doins php_pdo_int.h
}
