# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-sqlite/PECL-sqlite-1.0-r1.ebuild,v 1.3 2004/08/05 23:28:14 arj Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"
PHP_EXT_PECL_PKG="SQLite"

inherit php-ext-pecl

DEPEND="${DEPEND} =dev-db/sqlite-2* !dev-php/sqlite-php"

IUSE=""
DESCRIPTION="PHP bindings for the SQLite database engine"
HOMEPAGE="http://pear.php.net/SQLite"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

src_compile() {
	#use the external library, not the bundled one
	myconf="${myconf} --with-sqlite=/usr"
	php-ext-pecl_src_compile
}

src_install() {
	php-ext-pecl_src_install
	dodoc README TODO
}
