# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksquares/ksquares-4.6.3.ebuild,v 1.3 2011/06/10 11:50:20 hwoarang Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit games-ggz kde4-meta

DESCRIPTION="KSquares is an implementation of the game squares for KDE4"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

src_prepare() {
	# cmake is doing this really weird
	sed -i \
		-e "s:register_ggz_module:#register_ggz_module:g" \
		${PN}/src/CMakeLists.txt || die "ggz removal failed"

	kde4-meta_src_prepare
}

src_install() {
	kde4-meta_src_install
	# and also we have to prepare the ggz dir
	insinto "${GGZ_MODDIR}"
	newins ${PN}/src/module.dsc ${P}.dsc
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	games-ggz_pkg_postinst
}

pkg_postrm() {
	kde4-meta_pkg_postrm
	games-ggz_pkg_postrm
}
