# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/supertux/supertux-0.1.1-r1.ebuild,v 1.3 2005/01/19 00:20:15 wolf31o2 Exp $

inherit games

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://super-tux.sourceforge.net"
SRC_URI="mirror://sourceforge/super-tux/${P}.tar.bz2"

KEYWORDS="x86 ~ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="opengl"

RDEPEND="virtual/opengl
	virtual/x11
	>=media-libs/libsdl-1.1.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.5"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's/icflower/iceflower/g' src/scene.cpp \
		|| die "sed src/scene.cpp failed"
}

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

	cp data/images/icon.xpm supertux.xpm
	doicon supertux.xpm

	make_desktop_entry supertux SuperTux supertux.xpm

	prepgamesdirs
}
