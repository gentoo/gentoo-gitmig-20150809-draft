# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnugo/gnugo-3.3.22.ebuild,v 1.5 2004/07/14 14:29:58 agriffis Exp $

inherit games

DESCRIPTION="A Go-playing program"
SRC_URI="ftp://sporadic.stanford.edu/pub/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gnugo/devel.html"

KEYWORDS="x86 ~ppc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r3"

src_compile() {
	egamesconf --enable-cache-size=32 || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
	prepgamesdirs
}
