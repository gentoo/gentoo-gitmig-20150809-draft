# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-cairo/pecl-cairo-0.2.0.ebuild,v 1.1 2010/09/27 18:56:44 olemarkus Exp $

PHP_EXT_NAME="cairo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

EAPI="2"
inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Cairo bindings for PHP"
LICENSE="PHP-3.01"
SLOT="0"

DEPEND=">=dev-lang/php-5.2 >=x11-libs/cairo-1.4[svg]"
RDEPEND="${DEPEND}"

IUSE=""

need_php_by_category
S="${WORKDIR}/Cairo-${PV}"
