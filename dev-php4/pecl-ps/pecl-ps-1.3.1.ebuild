# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-ps/pecl-ps-1.3.1.ebuild,v 1.5 2006/04/10 21:24:39 blubb Exp $

PHP_EXT_NAME="ps"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="PHP extension for creating PostScript files."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		dev-libs/pslib"

need_php_by_category
