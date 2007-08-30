# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_Beautifier/PEAR-PHP_Beautifier-0.1.13.ebuild,v 1.1 2007/08/30 12:37:44 jokey Exp $

inherit php-pear-r1 depend.php eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Code Beautifier for PHP."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=dev-php/PEAR-Log-1.8"

need_php5

pkg_setup() {
	require_php_with_use tokenizer
}

pkg_postinst() {
	has_php
	if ! built_with_use --missing true =${PHP_PKG} bzip2 ; then
		elog "${PN} can optionally use bzip2 features."
		elog "If you want those, emerge ${PHP_PKG} with this flag in USE."
	fi
}
