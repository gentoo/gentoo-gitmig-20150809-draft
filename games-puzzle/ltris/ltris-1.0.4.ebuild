# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ltris/ltris-1.0.4.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

DESCRIPTION="very polished Tetris clone"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"
HOMEPAGE="http://lgames.sourceforge.net/"

KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	>=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodir /var/lib/games
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README TODO ChangeLog
}
