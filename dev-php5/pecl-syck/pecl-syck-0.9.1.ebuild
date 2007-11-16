# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-syck/pecl-syck-0.9.1.ebuild,v 1.4 2007/11/16 16:46:15 nixnut Exp $

PHP_EXT_NAME="syck"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CHANGELOG TODO"

inherit php-ext-pecl-r1

KEYWORDS="amd64 ~ppc x86"

DESCRIPTION="PHP bindings for Syck - an extension for reading and writing YAML swiftly in popular scripting languages."
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-libs/syck"
RDEPEND="${DEPEND}"

need_php_by_category
