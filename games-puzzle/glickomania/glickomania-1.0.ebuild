# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/glickomania/glickomania-1.0.ebuild,v 1.8 2006/02/17 22:05:37 tupone Exp $

inherit games

DESCRIPTION="An addictive variation of same game"
HOMEPAGE="http://hibase.cs.hut.fi/~cessu/glickomania/"
SRC_URI="http://hibase.cs.hut.fi/~cessu/glickomania/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_install() {
	dogamesbin src/glickomania || die "dogamesbin failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
