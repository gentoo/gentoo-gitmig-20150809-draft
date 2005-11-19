# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-tidy/pecl-tidy-1.1.ebuild,v 1.3 2005/11/19 20:50:27 corsair Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="tidy"
PHP_EXT_NAME="tidy"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

DESCRIPTION="Tidy is a binding for the Tidy HTML clean and repair utility."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="${DEPEND}
		app-text/htmltidy"

need_php_by_category

src_compile() {
	has_php
	my_conf="--with-tidy"
	php-ext-pecl-r1_src_compile
}
