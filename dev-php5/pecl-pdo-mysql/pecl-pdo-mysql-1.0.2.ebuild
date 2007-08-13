# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdo-mysql/pecl-pdo-mysql-1.0.2.ebuild,v 1.5 2007/08/13 10:08:23 jokey Exp $

PHP_EXT_NAME="pdo_mysql"
PHP_EXT_PECL_PKG="PDO_MYSQL"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"

DESCRIPTION="PHP Data Objects (PDO) Driver For MySQL Server."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=">=dev-php5/pecl-pdo-1.0.3
		virtual/mysql"
RDEPEND="${DEPEND}"

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

	# Fix charset settings and library linking
	epatch "${FILESDIR}/${P}-charsetphpini.patch"
	epatch "${FILESDIR}/${P}-ztsclientlib.patch"
}

src_compile() {
	has_php
	if has_zts ; then
		my_conf="--with-pdo-mysql=/usr --enable-maintainer-zts"
	else
		my_conf="--with-pdo-mysql=/usr"
	fi
	php-ext-pecl-r1_src_compile
}
