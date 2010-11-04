# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-dio/pecl-dio-0.0.4_rc4-r1.ebuild,v 1.1 2010/11/04 10:53:27 mabi Exp $

EAPI="3"

PHP_EXT_NAME="dio"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="docs/examples/tutorial.txt ThanksTo.txt KnownIssues.txt"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Direct I/O functions for PHP."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

MY_PV=${PV/_rc/RC}
S="${WORKDIR}/${PN/pecl-/}-${MY_PV}"

src_compile() {
	my_conf="--enable-dio --enable-shared"

	php-ext-pecl-r2_src_compile
}
