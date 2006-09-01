# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/conveysdl/conveysdl-1.3.ebuild,v 1.1 2006/09/01 22:10:03 tupone Exp $

inherit games

DESCRIPTION="Guide the blob along the conveyer belt collecting the red blobs, if you miss any you go round again"
HOMEPAGE="http://www.cloudsprinter.com/software/conveysdl/"
SRC_URI="http://www.cloudsprinter.com/software/conveysdl/${P/-/.}.tar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/libsdl
	>=media-libs/sdl-mixer"

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	unpack ${A}

	# Incomplete readme
	sed -i \
		-e 's:I k:use -nosound to disable sound\n\nI k:' \
		readme || die "sed readme failed"

	sed -i \
		-e 's:SDL_Mi:SDL_mi:' \
		main.c || die "sed main.c failed"
	mv main.c ${PN}.c
}

src_compile() {
	CFLAGS="${CFLAGS} `sdl-config --cflags`"
	CFLAGS="${CFLAGS} -DDATA_PREFIX=\\\"${GAMES_DATADIR}/${PN}/\\\""
	CFLAGS="${CFLAGS} -DENABLE_SOUND"
	emake "${PN}" LDLIBS="-lSDL_mixer `sdl-config --libs`" \
		|| die "emake failed"
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r gfx sounds levels || die "installing data failed"
	dodoc readme || die "installing docs failed"
	prepgamesdirs
}
