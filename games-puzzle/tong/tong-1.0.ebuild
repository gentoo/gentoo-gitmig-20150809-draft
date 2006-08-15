# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tong/tong-1.0.ebuild,v 1.4 2006/08/15 15:05:05 tcort Exp $

inherit eutils games

DESCRIPTION="Tetris and Pong in the same place at the same time"
HOMEPAGE="http://www.nongnu.org/tong/"
SRC_URI="http://www.nongnu.org/tong/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-makefile.patch"
	sed -i \
		-e "s:\"media/:\"${GAMES_DATADIR}/${PN}/media/:" \
		media.cpp option.cpp option.h pong.cpp tetris.cpp text.cpp \
		|| die "sed failed"
	cp media/icon.png "${T}/${PN}.png"
}

src_install() {
	dogamesbin tong || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r media/ "${D}/${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc CHANGELOG README making-of.txt CREDITS

	make_desktop_entry tong TONG ${PN}.png
	doicon "${T}/${PN}.png"
	prepgamesdirs
}
