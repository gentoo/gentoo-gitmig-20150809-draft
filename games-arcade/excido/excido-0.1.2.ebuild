# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit games

DESCRIPTION="A fast paced action game"
HOMEPAGE="http://icculus.org/excido/"
SRC_URI="http://icculus.org/excido/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="dev-games/physfs
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:\"helmetr.ttf\":\"${GAMES_DATADIR}/${PN}/helmetr.ttf\":" src/Camera.cpp || \
			die "sed Camera.cpp failed"

	sed -i \
		-e "s:\"helmetr.ttf\":\"${GAMES_DATADIR}/${PN}/helmetr.ttf\":" src/Menu.cpp || \
			die "sed Menu.cpp failed"

	sed -i \
		-e "s:\"data\":\"${GAMES_DATADIR}/${PN}\":" src/main.cpp || \
			die "sed main.cpp failed"

	sed -i \
		-e "s/-Wall .*/${CXXFLAGS}/" Makefile || \
			die "sed Makefile failed"
}

src_install() {
	dogamesbin excido
	dodir ${GAMES_DATADIR}/${PN}
	cp helmetr.ttf data/*.{wav,png} ${D}${GAMES_DATADIR}/${PN}
	dodoc excido.conf BUGS CHANGELOG HACKING INSTALL README RELNOTES* \
		keyguide.txt data/CREDITS data/*.txt
	prepgamesdirs
}

pkg_postinst() {
	einfo "${PN} will look for a excido.conf in the current directory but"
	einfo "it isn't necessary to play the game.  An example file is located"
	einfo "in /usr/share/doc/${P}"
	games_pkg_postinst
}
