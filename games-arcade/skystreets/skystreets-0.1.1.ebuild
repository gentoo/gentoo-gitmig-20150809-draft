# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/skystreets/skystreets-0.1.1.ebuild,v 1.1 2003/11/24 07:39:48 mr_bones_ Exp $

inherit games

S="${WORKDIR}/${PN}"
DESCRIPTION="A clone of the old dos Skyroads game"
HOMEPAGE="http://skystreets.kaosfusion.com/"
SRC_URI="http://skystreets.kaosfusion.com/${PN}_src_${PV}.tar.bz2
	http://skystreets.kaosfusion.com/${PN}_data_${PV}.tar.bz2"

KEYWORDS="x86"
LICENSE="OSL-2.0"
SLOT="0"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:-O2:${CXXFLAGS}:" Makefile || \
			die "sed Makefile failed"
	sed -i \
		-e "s:\[TEXTURES\]\[32\]:\[TEXTURES\]\[64\]:" \
		-e "s:\"levels/:\"${GAMES_DATADIR}/${PN}/levels/:g" \
		-e "s:\"gfx/:\"${GAMES_DATADIR}/${PN}/gfx/:g" \
			levels.cpp menu.cpp skystreets.cpp || \
				die "sed failed"
}

src_install() {
	dogamesbin skystreets                           || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"                  || die "dodir failed"
	cp -R gfx/ levels/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc LevelFormat README TODO                   || die "dodoc failed"
	prepgamesdirs
}
