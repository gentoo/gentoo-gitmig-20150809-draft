# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/miniracer/miniracer-1.04.ebuild,v 1.1 2005/06/01 03:44:06 mr_bones_ Exp $

inherit games

DESCRIPTION="an OpenGL car racing game, based on ID's famous Quake® engine"
HOMEPAGE="http://miniracer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/x11
	media-libs/libsdl
	media-libs/sdl-mixer"

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
