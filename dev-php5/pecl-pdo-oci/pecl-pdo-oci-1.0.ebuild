# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdo-oci/pecl-pdo-oci-1.0.ebuild,v 1.10 2007/03/04 20:48:10 chtekk Exp $

PHP_EXT_NAME="pdo_oci"
PHP_EXT_PECL_PKG="PDO_OCI"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="-* amd64 ia64 x86"

DESCRIPTION="PHP Data Objects (PDO) Driver For Oracle Call Interface (OCI)."
LICENSE="PHP"
SLOT="0"
IUSE="oci8-instant-client"

DEPEND="dev-php5/pecl-pdo
		oci8-instant-client? ( dev-db/oracle-instantclient-basic )"
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

src_compile() {
	has_php
	if use oci8-instant-client ; then
		OCI8IC_PKG="`best_version dev-db/oracle-instantclient-basic`"
		OCI8IC_PKG="`printf ${OCI8IC_PKG} | sed -e 's|dev-db/oracle-instantclient-basic-||g' | sed -e 's|-r.*||g'`"
		my_conf="--with-pdo-oci=instantclient,/usr,${OCI8IC_PKG}"
	else
		my_conf="--with-pdo-oci"
	fi
	php-ext-pecl-r1_src_compile
}
