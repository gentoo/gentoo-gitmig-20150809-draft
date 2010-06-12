# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Download/PEAR-HTTP_Download-1.1.3-r1.ebuild,v 1.1 2010/06/12 21:42:55 mabi Exp $

EAPI="2"

inherit php-pear-r1  eutils

DESCRIPTION="Provides functionality to send HTTP downloads."
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"
DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"
RDEPEND="${DEPEND}
	dev-php/PEAR-HTTP_Header
	!minimal? ( dev-php/PEAR-MIME_Type )"

pkg_postinst() {
	has_php
	if ! use minimal && ! built_with_use --missing true =${PHP_PKG} postgres ; then
		elog "${PN} can optionally use ${PHP_PKG} postgres features."
		elog "If you want those, recompile ${PHP_PKG} with this flags in USE."
	fi
}
