# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-bbcode/pecl-bbcode-0.10.4.ebuild,v 1.1 2007/11/15 19:10:26 jokey Exp $

PHP_EXT_NAME="bbcode"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~x86"

DESCRIPTION="A quick and efficient BBCode Parsing Library."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category
