# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-translit/pecl-translit-0.5.ebuild,v 1.1 2006/09/29 20:25:12 sebastian Exp $

PHP_EXT_NAME="translit"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Transliterates non-latin character sets to latin."
LICENSE="PHP"
SLOT="0"
IUSE=""

need_php_by_category
