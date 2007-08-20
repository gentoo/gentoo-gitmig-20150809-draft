# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Download/PEAR-HTTP_Download-1.1.1.ebuild,v 1.2 2007/08/20 21:44:44 jokey Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Provides functionality to send HTTP downloads."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"
RDEPEND="dev-php/PEAR-HTTP_Header
	!minimal? ( dev-php/PEAR-MIME_Type )"

pkg_setup() {
	require_php_with_use pcre
}

pkg_postinst() {
	has_php
	if ! use minimal && ! built_with_use --missing true =${PHP_PKG} postgres ; then
		elog "${PN} can optionally use ${PHP_PKG} postgres features."
		elog "If you want those, recompile ${PHP_PKG} with this flags in USE."
	fi
}
