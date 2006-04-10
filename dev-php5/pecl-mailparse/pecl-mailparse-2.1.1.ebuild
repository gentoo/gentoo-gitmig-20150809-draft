# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-mailparse/pecl-mailparse-2.1.1.ebuild,v 1.5 2006/04/10 21:23:56 blubb Exp $

PHP_EXT_NAME="mailparse"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="A PHP extension for parsing and working with RFC822 and RFC2045 (MIME) compliant messages."
LICENSE="PHP"
SLOT="0"
IUSE=""

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use nls
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Patch against segfaults
	epatch "${FILESDIR}/cvs-mailparse.c-fix.diff"
}

src_install() {
	php-ext-pecl-r1_src_install
	dodoc-php README
}
