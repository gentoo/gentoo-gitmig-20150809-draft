# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/supertux/supertux-0.1.1.ebuild,v 1.1 2004/05/13 01:11:27 mr_bones_ Exp $

inherit games

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://super-tux.sourceforge.net"
SRC_URI="mirror://sourceforge/super-tux/${P}.tar.bz2"

KEYWORDS="x86 ~ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="opengl"

DEPEND="virtual/opengl
	virtual/x11
	>=media-libs/libsdl-1.1.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.5"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL LEVELDESIGN README TODO.txt
	prepgamesdirs
}
