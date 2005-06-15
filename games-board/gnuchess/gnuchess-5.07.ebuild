# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess/gnuchess-5.07.ebuild,v 1.6 2005/06/15 18:24:04 wolf31o2 Exp $

inherit games

DESCRIPTION="Console based chess interface"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
SRC_URI="mirror://gnu/chess/${P}.tar.gz"

KEYWORDS="x86 ppc sparc alpha amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="readline"

DEPEND="virtual/libc
	readline? ( sys-libs/readline )"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		`use_with readline` \
			|| die
	emake || die "emake failed"
}
src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS TODO doc/README || die "dodoc failed"
	prepgamesdirs
}
