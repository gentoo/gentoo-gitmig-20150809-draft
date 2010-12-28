# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-dbx/pecl-dbx-1.1.0-r1.ebuild,v 1.3 2010/12/28 19:24:49 ranger Exp $

EAPI="3"

PHP_EXT_NAME="dbx"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

# package does not support php5.3, version 1.1.1 will
USE_PHP="php5-2"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~ppc64 ~x86"

DESCRIPTION="The dbx module is a database abstraction layer."
LICENSE="PHP-3"
SLOT="0"
IUSE=""
