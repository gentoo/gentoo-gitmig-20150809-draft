# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/greedy/greedy-0.2.0.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

DESCRIPTION="fun little ncurses puzzle game"
HOMEPAGE="http://www.kotinet.com/juhamattin/linux/index.html"
SRC_URI="http://www.kotinet.com/juhamattin/linux/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	sys-libs/ncurses"

src_compile() {
	emake || die
}

src_install() {
	# It wants a scores file.  We need to touch one and install it.
	touch greedy.scores
	insinto /var/lib/games
	doins greedy.scores || die

	dobin greedy || die
	dodoc CHANGES README TODO || die
}

pkg_postinst() {
	# We need to set the permissions correctly
	chown games.games /var/lib/games/greedy.scores || die
	chmod 664 /var/lib/games/greedy.scores || die

	chown games.games /usr/bin/greedy || die
}
