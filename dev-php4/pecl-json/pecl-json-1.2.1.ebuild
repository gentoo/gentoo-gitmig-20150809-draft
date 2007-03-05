# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-json/pecl-json-1.2.1.ebuild,v 1.3 2007/03/05 18:36:19 chtekk Exp $

PHP_EXT_NAME="json"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension for JSON serialisation."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category
