# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnugo/gnugo-3.4.ebuild,v 1.3 2004/02/05 22:17:37 mr_bones_ Exp $

inherit games

DESCRIPTION="A Go-playing program"
SRC_URI="ftp://sporadic.stanford.edu/pub/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gnugo/devel.html"

KEYWORDS="x86 ~ppc alpha"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r3"

src_compile() {
	egamesconf --enable-cache-size=32 || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO \
		|| die "dodoc failed"
	prepgamesdirs
}
