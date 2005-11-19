# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-crack/pecl-crack-0.2.ebuild,v 1.4 2005/11/19 20:38:15 corsair Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="crack"
PHP_EXT_NAME="crack"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

DESCRIPTION="PHP interface to the cracklib (libcrack) libraries"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="${DEPEND}
		sys-libs/cracklib"

need_php_by_category
