# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-dbx/pecl-dbx-1.1.0.ebuild,v 1.10 2011/01/30 16:38:04 armin76 Exp $

PHP_EXT_NAME="dbx"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="The dbx module is a database abstraction layer."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="<dev-lang/php-5.3"
RDEPEND="${DEPEND}"

need_php_by_category
