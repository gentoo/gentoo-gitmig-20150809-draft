# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/glickomania/glickomania-1.0.ebuild,v 1.2 2004/02/20 06:53:35 mr_bones_ Exp $

inherit games

DESCRIPTION="An addictive variation of same game"
HOMEPAGE="http://hibase.cs.hut.fi/~cessu/glickomania/"
SRC_URI="http://hibase.cs.hut.fi/~cessu/glickomania/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
		virtual/x11"

src_install() {
	dogamesbin src/glickomania || die "dogamesbin failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO || die "dodoc failed"
	prepgamesdirs
}
