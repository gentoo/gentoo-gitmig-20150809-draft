# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-crack/pecl-crack-0.2.ebuild,v 1.5 2005/11/24 22:14:05 chtekk Exp $

PHP_EXT_NAME="crack"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~ppc ~ppc64 ~x86"
DESCRIPTION="PHP interface to the cracklib libraries."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		sys-libs/cracklib"

need_php_by_category
