# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-0.70.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

inherit games

DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.freesoftware.fsf.org/enigma/"
SRC_URI="http://freesoftware.fsf.org/download/enigma/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	>=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.0
	>=media-libs/sdl-image-1.2.0
	=dev-lang/lua-4.0"

src_compile() {
	egamesconf --enable-optimize || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS TODO README COPYING.GPL AUTHORS INSTALL ChangeLog
	prepgamesdirs
}
