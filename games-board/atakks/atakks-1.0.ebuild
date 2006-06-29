# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/atakks/atakks-1.0.ebuild,v 1.7 2006/06/29 19:22:15 wolf31o2 Exp $

inherit eutils games

MY_P=${P/-/_}
DESCRIPTION="A clone of Ataxx"
HOMEPAGE="http://team.gcu-squad.org/~fab"
# no version upstream
#SRC_URI="http://team.gcu-squad.org/~fab/down/${PN}.tgz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.7"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Modify game data paths
	sed -i \
		-e "s:SDL_LoadBMP(\":SDL_LoadBMP(\"${GAMES_DATADIR}/${PN}/:" \
		main.c || die "sed failed"

	# Modify Makefile (CFLAGS and language)
	sed -i \
		-e 's:^CFLAGS=:CFLAGS= $(E_CFLAGS) -DUS:' \
		-e "s:^LDFLAGS.*$:LDFLAGS+=$(sdl-config --libs):" \
		Makefile || die "sed failed"

	epatch "${FILESDIR}/${PV}-warnings.patch"
}

src_compile() {
	emake E_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin atakks || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins *bmp || die "doins failed"
	prepgamesdirs
}
