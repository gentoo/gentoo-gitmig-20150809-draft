# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/supertux/supertux-0.0.6.ebuild,v 1.1 2004/03/30 11:05:27 mr_bones_ Exp $

inherit games
use debug && inherit debug

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://www.newbreedsoftware.com/supertux/"
SRC_URI="mirror://sourceforge/super-tux/${P}.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug opengl"

RDEPEND="virtual/opengl
	virtual/x11
	>=media-libs/libsdl-1.1.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		`use_enable debug` \
		`use_enable opengl` \
			|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL LEVELDESIGN README TODO.txt
	prepgamesdirs
}
