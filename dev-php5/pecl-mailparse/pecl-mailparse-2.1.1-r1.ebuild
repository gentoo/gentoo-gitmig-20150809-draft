# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-mailparse/pecl-mailparse-2.1.1-r1.ebuild,v 1.1 2007/09/04 18:41:28 jokey Exp $

PHP_EXT_NAME="mailparse"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

DOCS="README"
inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="A PHP extension for parsing and working with RFC822 and RFC2045 (MIME) compliant messages."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use unicode
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch against segfaults
	epatch "${FILESDIR}/cvs-mailparse.c-fix.diff"
	epatch "${FILESDIR}/mailparse-c-64bit-segfault.diff" # PECL Bug #7722

	# PECL bug #9624
	epatch "${FILESDIR}/mailparse_mime-rfc2231.diff"
}
