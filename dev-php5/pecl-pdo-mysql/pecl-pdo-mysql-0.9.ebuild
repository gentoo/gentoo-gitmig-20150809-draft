# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdo-mysql/pecl-pdo-mysql-0.9.ebuild,v 1.6 2005/11/11 02:10:12 vapier Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="PDO_MYSQL"
PHP_EXT_NAME="pdo_mysql"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="PHP Data Objects (PDO) Driver For MySQL 3.X/4.X Server"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~s390 ~sparc ~x86"
DEPEND="${DEPEND}
		dev-php5/pecl-pdo
		dev-db/mysql"

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

src_compile() {
	has_php
	my_conf="--with-pdo-mysql=/usr"
	php-ext-pecl-r1_src_compile
}
