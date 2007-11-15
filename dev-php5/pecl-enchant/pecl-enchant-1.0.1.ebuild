# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-enchant/pecl-enchant-1.0.1.ebuild,v 1.1 2007/11/15 19:11:59 jokey Exp $

PHP_EXT_NAME="enchant"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="docs/examples/example1.php"

inherit php-ext-pecl-r1

KEYWORDS="~x86"

DESCRIPTION="PHP bindings for the Enchant spellchecking wrapper library."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=">=app-text/enchant-1.1.3"
RDEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	my_conf="--with-enchant=/usr"
	php-ext-pecl-r1_src_compile
}
