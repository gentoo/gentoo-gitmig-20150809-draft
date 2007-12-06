# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-zip/pecl-zip-1.8.6.ebuild,v 1.11 2007/12/06 01:22:42 jokey Exp $

PHP_EXT_NAME="zip"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

DESCRIPTION="PHP zip management extension."
LICENSE="PHP-3.01 BSD"
SLOT="0"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

need_php_by_category
