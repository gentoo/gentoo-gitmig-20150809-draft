# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-dbx/pecl-dbx-1.1.0.ebuild,v 1.6 2006/05/27 00:49:51 chtekk Exp $

PHP_EXT_NAME="dbx"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="The dbx module is a database abstraction layer."
LICENSE="PHP"
SLOT="0"
IUSE=""

need_php_by_category

src_compile() {
	has_php
	my_conf="--enable-dbx"
	php-ext-pecl-r1_src_compile
}
