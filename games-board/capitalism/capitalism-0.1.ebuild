# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/capitalism/capitalism-0.1.ebuild,v 1.3 2009/12/24 16:16:14 pacho Exp $

EAPI=2
inherit eutils gnome2-utils qt4 games

MY_PN=${PN/c/C}

DESCRIPTION="A monopd compatible boardgame to play Monopoly-like games"
HOMEPAGE="http://www.qt-apps.org/content/show.php/Capitalism?content=113173"
SRC_URI="http://www.qt-apps.org/CONTENT/content-files/113173-${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${MY_PN}

pkg_setup() {
	games_pkg_setup
	qt4_pkg_setup
}

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
