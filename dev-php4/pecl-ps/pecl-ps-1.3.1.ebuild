# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-ps/pecl-ps-1.3.1.ebuild,v 1.3 2005/11/19 20:48:21 corsair Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="ps"
PHP_EXT_NAME="ps"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="PHP extension for creating PostScript files."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~ppc ~ppc64 ~sparc ~x86"
DEPEND="${DEPEND}
		dev-libs/pslib"

need_php_by_category
