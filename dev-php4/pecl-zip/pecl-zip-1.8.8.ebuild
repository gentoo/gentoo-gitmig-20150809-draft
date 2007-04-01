# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-zip/pecl-zip-1.8.8.ebuild,v 1.2 2007/04/01 08:17:51 vapier Exp $

PHP_EXT_NAME="zip"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

DESCRIPTION="PHP zip management extension."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ia64 ~ppc ~ppc64 s390 sh ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

need_php_by_category
