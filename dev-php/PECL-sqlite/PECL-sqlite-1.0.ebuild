# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-sqlite/PECL-sqlite-1.0.ebuild,v 1.1 2003/07/26 11:56:25 coredumb Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_NAME="sqlite"
PHP_EXT_INI="yes"

inherit php-ext-source

DEPEND="${DEPEND} >=dev-db/sqlite-2.8.5"

IUSE=""
DESCRIPTION="PHP bindings for the SQLite database engine"
HOMEPAGE="http://pear.php.net/SQLite"
SLOT="0"
MY_PN="SQLite"
SRC_URI="http://pear.php.net/get/${MY_PN}-${PV}.tgz"
S=${WORKDIR}/${MY_PN}-${PV}
LICENSE="PHP"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

src_compile() {
	#use the external library, not the bundled one
	myconf="${myconf} --with-sqlite=/usr"
	php-ext-source_src_compile
}

src_install() {
	php-ext-source_src_install
	dodoc CREDITS README TODO
}
