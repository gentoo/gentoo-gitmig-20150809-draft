# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/skystreets/skystreets-0.2.1.ebuild,v 1.1 2004/01/12 22:17:26 mr_bones_ Exp $

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
}

src_install() {
	dogamesbin skystreets                           || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"                  || die "dodir failed"
	cp -R gfx/ levels/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc CREDITS LevelFormat README TODO           || die "dodoc failed"
	rm -rf `find "${D}/usr/share/games/${PN}" -type d -name CVS`
	prepgamesdirs
}
