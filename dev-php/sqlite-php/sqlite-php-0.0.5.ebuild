# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/sqlite-php/sqlite-php-0.0.5.ebuild,v 1.1 2003/07/25 10:47:21 stuart Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PHP bindings for SQLite"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://sourceforge.net/projects/sqlite-php/"
DEPEND="virtual/glibc
	>=dev-php/php-4.2
	>=dev-db/sqlite-2.7"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

PHP_EXT_NAME="sqlite"
PHP_ZEND_EXT=

inherit php-ext-source php-ext-base

src_compile() {
	myconf="${myconf} --with-sqlite=shared"
	php-ext-source_src_compile
}

src_install () {

	php-ext-source_src_install
	php-ext-base_src_install
	dodoc README CREDITS CHANGES 

}
