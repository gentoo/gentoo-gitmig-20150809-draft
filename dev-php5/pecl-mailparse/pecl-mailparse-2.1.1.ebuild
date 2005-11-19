# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-mailparse/pecl-mailparse-2.1.1.ebuild,v 1.3 2005/11/19 21:01:08 corsair Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="A PHP extension for parsing and working with RFC822 and RFC2045 (MIME) compliant messages."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~ppc ~ppc64 ~sparc ~x86"

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use nls
}

src_unpack() {
	unpack ${A}

	cd ${S}

	# Patch against segfaults
	epatch ${FILESDIR}/cvs-mailparse.c-fix.diff
}

src_install() {
	php-ext-pecl-r1_src_install
	dodoc README
}
