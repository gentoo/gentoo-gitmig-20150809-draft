# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess-book/gnuchess-book-1.00.ebuild,v 1.3 2004/06/24 22:17:55 agriffis Exp $

inherit games

DESCRIPTION="Opening book for gnuchess"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
SRC_URI="mirror://gnu/chess/book_${PV}.pgn.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="games-board/gnuchess"

S="${WORKDIR}"

src_compile() {
	echo -e "book add book_${PV}.pgn"$'\n'"quit" | ${GAMES_BINDIR}/gnuchess \
		|| die "generation failed"
}

src_install() {
	insinto "${GAMES_DATADIR}/gnuchess"
	doins book.dat || die "doins failed"
	prepgamesdirs
}
