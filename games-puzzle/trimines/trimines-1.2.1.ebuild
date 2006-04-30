# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/trimines/trimines-1.2.1.ebuild,v 1.1 2006/04/30 22:00:39 mr_bones_ Exp $

inherit toolchain-funcs games

DESCRIPTION="A mine sweeper game that uses triangles instead of squares"
HOMEPAGE="http://www.freewebs.com/trimines/"
SRC_URI="http://www.freewebs.com/trimines/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:data/:${GAMES_DATADIR}/${PN}/:" src/gfx.c \
		|| die "sed failed"
	echo "${PN}: ; $(tc-getCC) ${CFLAGS} src/main.c -o ./${PN} \`sdl-config --cflags\` \`sdl-config --libs\`" > Makefile
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins data/* || die "doins failed"
	dodoc README
	make_desktop_entry "${PN}" TriMines
	prepgamesdirs
}
