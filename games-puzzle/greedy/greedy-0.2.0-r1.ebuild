# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/greedy/greedy-0.2.0-r1.ebuild,v 1.8 2008/05/15 13:03:38 nyhm Exp $

inherit games

DESCRIPTION="fun little ncurses puzzle game"
HOMEPAGE="http://www.kotinet.com/juhamattin/linux/index.html"
SRC_URI="http://www.kotinet.com/juhamattin/linux/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	emake FLAGS="${CFLAGS}" STRIP=ls || die "emake failed"
}

src_install() {
	# It wants a scores file.  We need to touch one and install it.
	touch greedy.scores
	insinto "${GAMES_STATEDIR}"
	doins greedy.scores || die "doins failed"

	dogamesbin greedy || die "dogamesbin failed"
	dodoc CHANGES README TODO

	prepgamesdirs
	# We need to set the permissions correctly
	fperms 664 "${GAMES_STATEDIR}/greedy.scores" || die "fperms failed"
}
