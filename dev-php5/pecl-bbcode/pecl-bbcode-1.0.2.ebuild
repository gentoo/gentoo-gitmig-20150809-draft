# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-bbcode/pecl-bbcode-1.0.2.ebuild,v 1.2 2010/10/18 18:40:13 olemarkus Exp $

PHP_EXT_NAME="bbcode"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="A quick and efficient BBCode Parsing Library."
LICENSE="PHP-3.01 BSD"
SLOT="0"
IUSE=""

DEPEND="<dev-lang/php-5.3"
RDEPEND=""

need_php_by_category
