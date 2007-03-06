# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-tidy/pecl-tidy-1.2.ebuild,v 1.1 2007/03/06 21:14:48 chtekk Exp $

PHP_EXT_NAME="tidy"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="Bindings for the Tidy HTML clean and repair utility."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="app-text/htmltidy"
RDEPEND="${DEPEND}"

need_php_by_category
