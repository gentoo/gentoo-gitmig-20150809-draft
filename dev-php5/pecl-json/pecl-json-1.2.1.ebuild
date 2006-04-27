# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-json/pecl-json-1.2.1.ebuild,v 1.1 2006/04/27 20:36:12 chtekk Exp $

PHP_EXT_NAME="json"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~x86"
DESCRIPTION="PHP extension for JSON serialisation."
LICENSE="PHP"
SLOT="0"
IUSE=""

need_php_by_category
