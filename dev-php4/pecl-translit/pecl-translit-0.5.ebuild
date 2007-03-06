# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-translit/pecl-translit-0.5.ebuild,v 1.2 2007/03/06 21:40:59 chtekk Exp $

PHP_EXT_NAME="translit"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Transliterates non-latin character sets to latin."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category
