# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-sqlite/PECL-sqlite-1.0.3.ebuild,v 1.2 2004/08/03 20:28:37 agriffis Exp $

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
KEYWORDS="~x86 ~alpha ~sparc ~ppc ~ia64"

src_compile() {
	if has_version ">=virtual/php-5.0.0"; then
		eerror "Since PHP 5.0.0, SQLite is bundled in the PHP distribution,"
		eerror "the PECL extension is intended only for use with the PHP 4.3.x series."
		eerror "To use SQLite with PHP5, add 'sqlite' into USE and remerge php."
		die
	fi
	php-ext-pecl_src_compile
}

src_install() {
	php-ext-pecl_src_install
	dodoc README TODO
}
