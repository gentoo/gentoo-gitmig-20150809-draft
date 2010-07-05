# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-dio/pecl-dio-0.0.4_rc4.ebuild,v 1.1 2010/07/05 11:50:09 mabi Exp $

PHP_EXT_NAME="dio"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="docs/examples/tutorial.txt ThanksTo.txt KnownIssues.txt"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Direct I/O functions for PHP."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

need_php_by_category

MY_PV=${PV/_rc/RC}
S="${WORKDIR}/${PN/pecl-/}-${MY_PV}"

src_compile() {
	my_conf="--enable-dio --enable-shared"

	php-ext-pecl-r1_src_compile
}
