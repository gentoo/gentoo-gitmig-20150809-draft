# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-enchant/pecl-enchant-1.1.0-r2.ebuild,v 1.1 2011/12/14 22:34:32 mabi Exp $

EAPI="3"

PHP_EXT_NAME="enchant"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="docs/examples/example1.php"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP bindings for the Enchant spellchecking wrapper library."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=">=app-text/enchant-1.1.3"
RDEPEND="${DEPEND}"

src_configure() {
	my_conf="--with-enchant=/usr"
	php-ext-source-r2_src_configure
}
