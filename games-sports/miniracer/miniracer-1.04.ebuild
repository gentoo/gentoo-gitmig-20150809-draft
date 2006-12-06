# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/miniracer/miniracer-1.04.ebuild,v 1.4 2006/12/06 20:28:17 wolf31o2 Exp $

inherit games

DESCRIPTION="an OpenGL car racing game, based on ID's famous Quake engine"
HOMEPAGE="http://miniracer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	media-libs/mesa
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CC=/d' \
		-e "s:\$(DESTDIR)/usr/bin:\$(DESTDIR)${GAMES_BINDIR}:" \
		-e "/INCLUDES/s:-I/usr/include/SDL:$(sdl-config --cflags):" \
		-e "/CFLAGS/s:-O3 -march=i486 -ffast-math -fexpensive-optimizations:${CFLAGS}:" \
		-e "/LDFLAGS/s:-lSDL -lSDL_mixer -lpthread:$(sdl-config --libs) -lSDL_mixer:" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc TODO README ChangeLog
	prepgamesdirs
}
