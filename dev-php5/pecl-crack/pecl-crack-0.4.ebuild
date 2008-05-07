# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-crack/pecl-crack-0.4.ebuild,v 1.9 2008/05/07 16:32:02 hoffie Exp $

PHP_EXT_NAME="crack"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="EXPERIMENTAL"

inherit php-ext-pecl-r1

KEYWORDS="amd64 ppc ppc64 ~sparc x86"

DESCRIPTION="PHP interface to the cracklib libraries."
LICENSE="PHP-3 CRACKLIB"
SLOT="0"
IUSE=""

DEPEND=""

need_php_by_category

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch for http://pecl.php.net/bugs/bug.php?id=5765
	epatch "${FILESDIR}/fix-pecl-bug-5765.patch"

	php-ext-source-r1_src_unpack
}
