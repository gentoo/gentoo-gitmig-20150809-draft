# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/late/late-0.1.0.ebuild,v 1.8 2004/11/02 21:02:02 josejx Exp $

inherit games

DESCRIPTION="A game, similar to Barrack by Ambrosia Software"
SRC_URI="mirror://sourceforge/late/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://late.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.8
	media-libs/sdl-image"

src_install () {
	egamesinstall || die
	dodoc AUTHORS
	prepgamesdirs
}
