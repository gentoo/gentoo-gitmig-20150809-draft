# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/openglad/openglad-0.98.ebuild,v 1.1 2003/09/10 06:26:50 vapier Exp $

inherit games

DESCRIPTION="An SDL clone of Gladiator, a classic RPG game"
HOMEPAGE="http://snowstorm.sf.net/"
SRC_URI="mirror://sourceforge/snowstorm/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/libsdl-1.2.0"

src_compile() {
	egamesconf --datadir=/usr/share/games/openglad \
		--prefix=/usr --bindir=/usr/games/bin || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	rm ${D}${GAMES_DATADIR_BASE}/doc/${PN}/COPYING
	gzip -9 ${D}${GAMES_DATADIR_BASE}/doc/${PN}/*
	prepgamesdirs
}
