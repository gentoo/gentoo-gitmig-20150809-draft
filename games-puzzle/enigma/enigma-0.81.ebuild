# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-0.81.ebuild,v 1.1 2003/10/14 01:53:25 mr_bones_ Exp $

inherit games

DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.freesoftware.fsf.org/enigma/"
SRC_URI="http://savannah.nongnu.org/download/enigma/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	sys-libs/zlib
	media-libs/sdl-ttf
	>=media-libs/libsdl-1.2.0
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-image-1.2.0
	>=dev-lang/lua-4.0"

src_compile() {
	egamesconf --enable-optimize || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS README AUTHORS INSTALL ChangeLog || die "dodoc failed"
	prepgamesdirs
}
