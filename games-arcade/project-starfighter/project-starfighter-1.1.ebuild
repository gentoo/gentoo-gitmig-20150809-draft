# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/project-starfighter/project-starfighter-1.1.ebuild,v 1.8 2004/11/02 21:05:19 josejx Exp $

inherit games

MY_P=${P/project-/}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A space themed shooter"
HOMEPAGE="http://www.parallelrealities.co.uk/starfighter.php"
# FIXME: Parallel Realities uses a lame download script.
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="x86 sparc ~amd64 ~ppc"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"
DEPEND="$RDEPEND
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S} && \
	sed -i \
		-e "s-O3${CXXFLAGS}"  makefile || \
			die "sed makefile failed"
}

src_compile() {
	emake DATA="${GAMES_DATADIR}/parallelrealities/" || die "emake failed"
}

src_install () {
	dogamesbin starfighter || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/parallelrealities/"
	doins starfighter.pak
	dohtml -r docs/
	prepgamesdirs
}
