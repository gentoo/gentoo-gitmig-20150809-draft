# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kajaani-kombat/kajaani-kombat-0.6.6.6.ebuild,v 1.2 2006/12/06 17:03:35 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="A rampart-like game set in space"
HOMEPAGE="http://kombat.kajaani.net/"
SRC_URI="http://kombat.kajaani.net/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-net
	media-libs/sdl-image
	media-libs/sdl-ttf
	sys-libs/ncurses
	sys-libs/readline"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-makefile.patch"
	sed -i \
		-e "s:GENTOODIR:${GAMES_DATADIR}/${PN}/:" \
		Makefile \
		|| die "sed failed"
	sed -i \
		-e 's/IMG_Load/img_load/' \
		gui_screens.cpp \
		|| die "sed failed"
	chmod a-x *.{png,ttf,ogg}
}

src_install() {
	dogamesbin kajaani-kombat || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp *.{png,ttf,ogg} "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc AUTHORS ChangeLog README
	doman kajaani-kombat.6
	prepgamesdirs
}
