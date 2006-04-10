# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-tidy/pecl-tidy-1.1.ebuild,v 1.5 2006/04/10 21:25:00 blubb Exp $

PHP_EXT_NAME="tidy"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="Tidy is a binding for the Tidy HTML clean and repair utility."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		app-text/htmltidy"

need_php_by_category

src_compile() {
	has_php
	my_conf="--with-tidy"
	php-ext-pecl-r1_src_compile
}
