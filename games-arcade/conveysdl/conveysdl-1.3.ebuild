# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/conveysdl/conveysdl-1.3.ebuild,v 1.5 2009/02/02 09:02:35 tupone Exp $

EAPI=2
inherit eutils toolchain-funcs games

DESCRIPTION="Guide the blob along the conveyer belt collecting the red blobs"
HOMEPAGE="http://www.cloudsprinter.com/software/conveysdl/"
SRC_URI="http://www.cloudsprinter.com/software/conveysdl/${P/-/.}.tar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer"

S=${WORKDIR}

src_prepare() {
	# Incomplete readme
	sed -i \
		-e 's:I k:use -nosound to disable sound\n\nI k:' \
		readme \
		|| die "sed failed"

	sed -i \
		-e 's:SDL_Mi:SDL_mi:' \
		main.c \
		|| die "sed failed"
}

src_compile() {
	emake main \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} $(sdl-config --cflags) \
			-DDATA_PREFIX=\\\"${GAMES_DATADIR}/${PN}/\\\" \
			-DENABLE_SOUND" \
		LDLIBS="-lSDL_mixer $(sdl-config --libs)" \
		|| die "emake failed"
}

src_install() {
	newgamesbin main ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r gfx sounds levels || die "doins failed"
	newicon gfx/jblob.bmp ${PN}.bmp
	make_desktop_entry ${PN} Convey /usr/share/pixmaps/${PN}.bmp
	dodoc readme
	prepgamesdirs
}
