# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/openbubbles/openbubbles-1.2.ebuild,v 1.2 2007/03/26 18:04:05 tupone Exp $

inherit games

DESCRIPTION="A clone of Evan Bailey's game Bubbles"
HOMEPAGE="http://www.freewebs.com/lasindi/openbubbles/index.html"
SRC_URI="http://www.freewebs.com/lasindi/openbubbles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-gfx"

src_install() {
	dogamesbin src/openbubbles || die "openbubbles exe installation fails"
	insinto ${GAMES_DATADIR}/${PN}
	doins data/* || die "games data installation fails"
	dodoc AUTHORS ChangeLog NEWS README

	newincon data/bubble.png ${PN}.png
	make_desktop_entry ${PN} "OpenBubbles" ${PN}.png

	prepgamesdirs
}
