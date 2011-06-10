# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kigo/kigo-4.6.4.ebuild,v 1.1 2011/06/10 18:00:00 dilfridge Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit games-ggz kde4-meta

DESCRIPTION="KDE Go game"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	games-board/gnugo
"

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
