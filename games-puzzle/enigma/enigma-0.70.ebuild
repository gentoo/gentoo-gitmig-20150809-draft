# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-0.70.ebuild,v 1.3 2003/09/12 01:48:05 vapier Exp $

inherit games

DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.freesoftware.fsf.org/enigma/"
SRC_URI="http://freesoftware.fsf.org/download/enigma/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=media-libs/libsdl-1.2.0
	media-libs/sdl-mixer
	media-libs/sdl-image
	>=dev-lang/lua-4.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
}

src_compile() {
	egamesconf --enable-optimize || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS TODO README COPYING.GPL AUTHORS INSTALL ChangeLog
	prepgamesdirs
}
