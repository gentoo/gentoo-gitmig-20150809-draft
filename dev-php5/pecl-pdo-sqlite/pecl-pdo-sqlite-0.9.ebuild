# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdo-sqlite/pecl-pdo-sqlite-0.9.ebuild,v 1.8 2005/11/19 19:26:32 corsair Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="PDO_SQLITE"
PHP_EXT_NAME="pdo_sqlite"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="PHP Data Objects (PDO) Driver For SQLite Server"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
DEPEND="${DEPEND}
		dev-php5/pecl-pdo"

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

	# Patches config to latest CVS sources
	epatch ${FILESDIR}/config.m4.diff
}
