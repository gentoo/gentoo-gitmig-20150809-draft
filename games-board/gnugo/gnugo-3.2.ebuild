# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnugo/gnugo-3.2.ebuild,v 1.2 2004/02/05 22:17:37 mr_bones_ Exp $

DESCRIPTION="A Go-playing program"
SRC_URI="mirror://gnu/gnugo/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gnugo/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r3"

src_compile() {
	econf --enable-cache-size=32 --enable-dfa || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
