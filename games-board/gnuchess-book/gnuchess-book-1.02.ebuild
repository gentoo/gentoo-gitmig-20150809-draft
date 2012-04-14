# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess-book/gnuchess-book-1.02.ebuild,v 1.3 2012/04/14 11:42:13 ago Exp $

inherit games

DESCRIPTION="Opening book for gnuchess"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
SRC_URI="mirror://gnu/chess/book_${PV}.pgn.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RESTRICT="userpriv" # bug #112898

DEPEND=">=games-board/gnuchess-6"

S=${WORKDIR}

src_compile() {
	"${GAMES_BINDIR}"/gnuchess --addbook=book_${PV}.pgn \
			|| die "generation failed"
}

src_install() {
	insinto "${GAMES_DATADIR}/gnuchess"
	doins book.bin || die "doins failed"
	prepgamesdirs
}
