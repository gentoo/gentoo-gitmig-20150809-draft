# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-zip/pecl-zip-1.0.ebuild,v 1.17 2007/03/20 14:21:15 gustavoz Exp $

PHP_EXT_NAME="zip"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh x86"

DESCRIPTION="PHP zip management extension."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="dev-libs/zziplib"
RDEPEND="${DEPEND}"

need_php_by_category
