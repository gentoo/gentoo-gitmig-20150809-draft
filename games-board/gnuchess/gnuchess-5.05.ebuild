# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess/gnuchess-5.05.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games

S=${WORKDIR}/chess
DESCRIPTION="Console based chess interface"
SRC_URI="mirror://gnu/chess/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	egamesconf
	emake || die
}
src_install () {
	egamesinstall

	dodoc AUTHORS ChangeLog COPYING README INSTALL NEWS TODO

	prepgamesdirs
}
