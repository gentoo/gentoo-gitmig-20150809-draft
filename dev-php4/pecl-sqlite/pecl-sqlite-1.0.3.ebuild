# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-sqlite/pecl-sqlite-1.0.3.ebuild,v 1.7 2005/11/01 01:41:45 vapier Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"
PHP_EXT_PECL_PKG="SQLite"
PHP_EXT_NAME="sqlite"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="PHP bindings for the SQLite database engine"
HOMEPAGE="http://pear.php.net/SQLite"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~amd64 ~ppc ~s390 ~sparc ~x86"

need_php_by_category

src_install() {
	php-ext-pecl-r1_src_install
	dodoc README TODO
}
