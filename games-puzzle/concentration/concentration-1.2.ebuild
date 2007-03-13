# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/concentration/concentration-1.2.ebuild,v 1.3 2007/03/13 14:05:17 nyhm Exp $

inherit eutils games

DESCRIPTION="The classic memory game with some new life"
HOMEPAGE="http://www.shiftygames.com/concentration/"
SRC_URI="http://www.shiftygames.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon pics/set1/19.png ${PN}.png
	make_desktop_entry ${PN} Concentration
	dodoc AUTHORS ChangeLog
	prepgamesdirs
}
