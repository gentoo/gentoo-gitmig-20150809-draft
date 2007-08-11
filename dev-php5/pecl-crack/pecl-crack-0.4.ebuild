# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-crack/pecl-crack-0.4.ebuild,v 1.5 2007/08/11 04:04:40 beandog Exp $

PHP_EXT_NAME="crack"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="amd64 ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="PHP interface to the cracklib libraries."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch for http://pecl.php.net/bugs/bug.php?id=5765
	epatch "${FILESDIR}/fix-pecl-bug-5765.patch"
}
