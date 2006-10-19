# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/bastet/bastet-0.41.ebuild,v 1.8 2006/10/19 15:20:40 nyhm Exp $

inherit toolchain-funcs games

DESCRIPTION="a simple, evil, ncurses-based Tetris(R) clone"
HOMEPAGE="http://fph.altervista.org/prog/bastet.shtml"
SRC_URI="http://fph.altervista.org/prog/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^include/s/^/-/' \
		-e "/^CC/s/gcc/$(tc-getCC)/" \
		-e "/^DATA_PREFIX/s:=.*:=${GAMES_STATEDIR}/:" \
		-e '/^CFLAGS/s/=/+=/' \
		-e '/^LDFLAGS/s/=/+=/' \
		Makefile \
		|| die "sed failed"

	sed -i \
		-e 's/ch;/ch = 0;/' \
		main.c game.c \
		|| die "sed failed"
}

src_install() {
	dogamesbin bastet || die "dogamesbin failed"
	doman bastet.6
	dodoc AUTHORS BUGS NEWS README* TODO
	dodir "${GAMES_STATEDIR}"
	touch "${D}${GAMES_STATEDIR}/bastet.scores" || die "touch failed"
	fperms 664 "${GAMES_STATEDIR}/bastet.scores"
	prepgamesdirs
}
