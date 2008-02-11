# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-bbcode/pecl-bbcode-1.0.0.ebuild,v 1.1 2008/02/11 21:23:18 armin76 Exp $

PHP_EXT_NAME="bbcode"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

inherit php-ext-pecl-r1

KEYWORDS="~x86"

DESCRIPTION="A quick and efficient BBCode Parsing Library."
LICENSE="PHP-3.01 BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category
