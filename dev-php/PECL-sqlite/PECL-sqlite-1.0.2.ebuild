# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-sqlite/PECL-sqlite-1.0.2.ebuild,v 1.1 2004/01/24 17:14:34 coredumb Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"
PHP_EXT_PECL_PKG="SQLite"
PHP_EXT_NAME="sqlite"

inherit php-ext-pecl

DEPEND="${DEPEND} !dev-php/sqlite-php"

IUSE=""
DESCRIPTION="PHP bindings for the SQLite database engine"
HOMEPAGE="http://pear.php.net/SQLite"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

src_compile() {
	php-ext-pecl_src_compile
}

src_install() {
	php-ext-pecl_src_install
	dodoc README TODO
}
