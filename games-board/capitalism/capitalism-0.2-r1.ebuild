# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/capitalism/capitalism-0.2-r1.ebuild,v 1.1 2010/10/23 10:34:55 hwoarang Exp $

EAPI=2
inherit eutils gnome2-utils qt4-r2 games

MY_PN=${PN/c/C}

DESCRIPTION="A monopd compatible boardgame to play Monopoly-like games"
HOMEPAGE="http://www.qt-apps.org/content/show.php/Capitalism?content=113173"
SRC_URI="http://www.qt-apps.org/CONTENT/content-files/113173-${P}.tbz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${MY_PN}-${PV}

PATCHES=(
	"${FILESDIR}"/${P}-qt47.patch
)

src_configure() {
	eqmake4 ${MY_PN}.pro
}

src_install() {
	dogamesbin ${MY_PN} || die
	dodoc changelog readme.txt

	local res
	for res in 16 22 24 32 48 64; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins icons/${res}x${res}.png ${PN}.png
	done

	make_desktop_entry ${MY_PN} ${MY_PN}
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
