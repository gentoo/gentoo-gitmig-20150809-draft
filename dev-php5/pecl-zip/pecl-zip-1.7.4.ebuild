# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-zip/pecl-zip-1.7.4.ebuild,v 1.2 2006/09/30 17:56:52 the_paya Exp $

PHP_EXT_NAME="zip"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
DESCRIPTION="PHP zip management extension."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		sys-libs/zlib"

need_php_by_category
