# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-crack/pecl-crack-0.3.ebuild,v 1.6 2006/04/10 21:26:08 blubb Exp $

PHP_EXT_NAME="crack"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="PHP interface to the cracklib libraries."
LICENSE="PHP"
SLOT="0"
IUSE=""

need_php_by_category
