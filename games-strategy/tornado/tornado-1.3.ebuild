# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/tornado/tornado-1.3.ebuild,v 1.2 2004/12/03 07:20:33 mr_bones_ Exp $

inherit games

DESCRIPTION="Clone of a C64 game -  destroy the opponent's house"
HOMEPAGE="http://home.kcore.de/~kiza/linux/tornado/"
SRC_URI="http://home.kcore.de/~kiza/linux/tornado/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.3"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:/usr/local:/usr:" \
		-e "s:-O2:${CFLAGS}:" \
		Makefile || die "sed Makefile failed"
	sed -i \
		-e "s:PREFIX/bin:${GAMES_BINDIR}:" \
		-e "s:PREFIX/man:/usr/man:" \
		-e "s:/usr/local:/usr:" \
		doc/man/tornado.6.in || die "sed doc/man/tornado.6 failed"
}

src_install() {
	dogamesbin tornado || die
	doman doc/man/tornado.6
	dodoc AUTHOR CREDITS Changelog README TODO
	insinto "${GAMES_STATEDIR}"
	doins tornado.scores
	prepgamesdirs
	fperms 664 "${GAMES_STATEDIR}/tornado.scores"
}
