# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-cairo/pecl-cairo-0.2.0-r1.ebuild,v 1.1 2011/12/14 22:31:50 mabi Exp $

PHP_EXT_NAME="cairo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

EAPI="2"
inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Cairo bindings for PHP"
LICENSE="PHP-3.01"
SLOT="0"

DEPEND=">=dev-lang/php-5.2 >=x11-libs/cairo-1.4[svg]"
RDEPEND="${DEPEND}"

IUSE=""

S="${WORKDIR}/Cairo-${PV}"
