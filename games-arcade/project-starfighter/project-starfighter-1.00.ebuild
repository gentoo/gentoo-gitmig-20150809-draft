# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/project-starfighter/project-starfighter-1.00.ebuild,v 1.5 2004/07/14 14:25:11 agriffis Exp $

inherit games

DESCRIPTION="A space themed shooter"
HOMEPAGE="http://www.parallelrealities.co.uk/starfighter.php"
KEYWORDS="x86"
IUSE=""
LICENSE="as-is"

S="${WORKDIR}/Starfighter"
# Parallel Realities seems to always use the same name for releases.
SRC_URI="mirror://gentoo/${P}.tar.gz"

RDEPEND="virtual/libc
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"
DEPEND="$RDEPEND
	>=sys-apps/sed-4"

SLOT=0

src_unpack() {
	unpack ${A}
	cd ${S} && \
	sed -i \
		-e "s-g -O3${CXXFLAGS} `sdl-config --cflags`" \
		makefile || die "sed makefile failed"
}

src_compile() {
	emake DATA="${GAMES_DATADIR}/parallelrealities/" || die
}

src_install () {
	dogamesbin starfighter || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/parallelrealities/"
	doins starfighter.pak

	dodoc readme.txt
	dohtml -r manual/

	prepgamesdirs
}
