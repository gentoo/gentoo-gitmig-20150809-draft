# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/wakkabox/wakkabox-1.1.0.ebuild,v 1.4 2004/03/19 21:01:34 vapier Exp $

inherit games

DESCRIPTION="A simple block-pushing game"
HOMEPAGE="http://kenn.frap.net/wakkabox/"
SRC_URI="http://kenn.frap.net/wakkabox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.0.1"

src_install() {
	egamesinstall || die
	dodoc AUTHORS NEWS README
	prepgamesdirs
}
