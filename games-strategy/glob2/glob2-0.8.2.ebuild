# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glob2/glob2-0.8.2.ebuild,v 1.1 2004/02/21 21:36:25 vapier Exp $

inherit games

DESCRIPTION="state of the art Real Time Strategy (RTS) game"
HOMEPAGE="http://www.ysagoon.com/glob2/"
SRC_URI="http://www.ysagoon.com/glob2/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl"

DEPEND="media-libs/libsdl
	=media-libs/freetype-2*
	opengl? ( virtual/opengl )
	media-libs/libvorbis"

src_compile() {
	egamesconf `use_enable opengl` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
