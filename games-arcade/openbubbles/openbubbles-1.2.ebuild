# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/openbubbles/openbubbles-1.2.ebuild,v 1.5 2008/03/25 13:54:56 coldwind Exp $

inherit eutils games

DESCRIPTION="A clone of Evan Bailey's game Bubbles"
HOMEPAGE="http://www.freewebs.com/lasindi/openbubbles/index.html"
SRC_URI="http://www.freewebs.com/lasindi/openbubbles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-gfx"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	newicon data/bubble.png ${PN}.png
	make_desktop_entry ${PN} "OpenBubbles"
	prepgamesdirs
}
