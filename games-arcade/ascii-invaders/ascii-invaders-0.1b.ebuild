# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ascii-invaders/ascii-invaders-0.1b.ebuild,v 1.19 2008/12/05 18:58:43 nyhm Exp $

inherit toolchain-funcs games

DESCRIPTION="Space invaders clone, using ncurses library"
HOMEPAGE="http://www.ip9.org/munro/invaders/"
SRC_URI="http://www.ip9.org/munro/invaders/invaders${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/invaders

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" LDLIBS=-lncurses invaders || die "emake failed"
}

src_install() {
	newgamesbin invaders ${PN} || die "newgamesbin failed"
	dodoc TODO
	prepgamesdirs
}
