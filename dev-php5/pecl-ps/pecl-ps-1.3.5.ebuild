# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-ps/pecl-ps-1.3.5.ebuild,v 1.1 2007/08/31 09:52:57 jokey Exp $

PHP_EXT_NAME="ps"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="PHP extension for creating PostScript files."
LICENSE="PHP"
SLOT="0"
IUSE="examples"

DEPEND="dev-libs/pslib"
RDEPEND="${DEPEND}"

need_php_by_category
