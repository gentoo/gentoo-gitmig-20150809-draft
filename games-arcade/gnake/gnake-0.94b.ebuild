# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gnake/gnake-0.94b.ebuild,v 1.1 2006/01/05 16:12:13 wolf31o2 Exp $

inherit toolchain-funcs games

MY_PN="Gnake"
MY_P=${MY_PN}.${PV}

DESCRIPTION="An ncurses-based Nibbles clone"
HOMEPAGE="http://lightless.org/gnake"
SRC_URI="http://lightless.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/${PN}

src_compile() {
	LDFLAGS="-lncurses"
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o gnake gnake.c
}

src_install() {
	dogamesbin gnake || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}
