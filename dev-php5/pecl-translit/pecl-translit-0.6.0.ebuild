# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-translit/pecl-translit-0.6.0.ebuild,v 1.1 2010/11/04 16:17:09 mabi Exp $

PHP_EXT_NAME="translit"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Transliterates non-latin character sets to latin."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category
