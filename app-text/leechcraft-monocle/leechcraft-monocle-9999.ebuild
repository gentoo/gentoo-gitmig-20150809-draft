# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/leechcraft-monocle/leechcraft-monocle-9999.ebuild,v 1.1 2012/06/26 17:01:34 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Monocle, the modular document viewer for LeechCraft."

SLOT="0"
KEYWORDS=""
IUSE="debug +fb2 +pdf"

DEPEND="~net-misc/leechcraft-core-${PV}
		pdf? ( app-text/poppler[qt4] )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable fb2 MONOCLE_FXB)
		$(cmake-utils_use_enable pdf MONOCLE_PDF)"

	cmake-utils_src_configure
}
