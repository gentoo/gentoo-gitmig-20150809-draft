# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess/gnuchess-5.06.ebuild,v 1.2 2003/11/12 12:43:37 bazik Exp $

inherit games

DESCRIPTION="Console based chess interface"
SRC_URI="mirror://gnu/chess/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"

KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"
SLOT="0"

src_install () {
	egamesinstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS TODO doc/README || die "dodoc failed"
	prepgamesdirs
}
