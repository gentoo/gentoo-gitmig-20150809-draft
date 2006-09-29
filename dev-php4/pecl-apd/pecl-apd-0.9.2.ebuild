# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-apd/pecl-apd-0.9.2.ebuild,v 1.5 2006/09/29 06:22:16 sebastian Exp $

PHP_EXT_NAME="apd"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="yes"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~sparc ~x86"
DESCRIPTION="A full-featured engine-level profiler/debugger."
LICENSE="PHP"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND} >=dev-php/PEAR-PEAR-1.3.6-r2 !dev-php4/ZendOptimizer"

need_php_by_category

pkg_setup() {
	has_php

	require_php_cli
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}/fix-version-string-0.9.2.patch"
}

src_install() {
	sed -i 's:/usr/local/bin/php:/usr/lib/php4/bin/php:g' "${S}/pprofp" || die "Unable to replace PHP path"
	sed -i 's:pprofp:pprofp-php4:g' "${S}/pprofp" || die "Unable to replace PHP path"
	php-ext-pecl-r1_src_install
	newbin pprofp pprofp-php4
	dodoc-php LICENSE README
}
