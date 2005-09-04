# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-dbx/pecl-dbx-1.1.0.ebuild,v 1.1 2005/09/04 16:23:03 stuart Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="dbx"
PHP_EXT_NAME="dbx"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

DESCRIPTION="The dbx module is a database abstraction layer."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	has_php
	my_conf="--enable-dbx"
	php-ext-pecl-r1_src_compile
}
