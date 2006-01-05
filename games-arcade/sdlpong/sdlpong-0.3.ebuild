# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlpong/sdlpong-0.3.ebuild,v 1.1 2006/01/05 16:18:02 wolf31o2 Exp $

inherit games

DESCRIPTION="An SDL Pong clone"
HOMEPAGE="http://freshmeat.net/projects/sdlpong/"
SRC_URI="mirror://sourceforge/uninspiredsoft/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s#gfx/#${GAMES_DATADIR}/${PN}/gfx/#g" \
		video.c \
		|| die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto "${GAMES_DATADIR}/${PN}/gfx"
	doins -r gfx/* || die "doins failed"
	dodoc ChangeLog README TODO
	prepgamesdirs
}
