# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdo-pgsql/pecl-pdo-pgsql-1.0.1.ebuild,v 1.12 2006/02/24 14:02:12 jer Exp $

PHP_EXT_NAME="pdo_pgsql"
PHP_EXT_PECL_PKG="PDO_PGSQL"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
DESCRIPTION="PHP Data Objects (PDO) Driver For PostgreSQL Server."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		dev-php5/pecl-pdo
		dev-db/libpq"

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

	cd "${S}"

	# fix Gentoo bug #116914
	epatch "${FILESDIR}/fix-tsrm.patch"
}

src_compile() {
	has_php
	my_conf="--with-pdo-pgsql"
	php-ext-pecl-r1_src_compile
}
