# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/nprquake-sdl/nprquake-sdl-1.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games eutils

DESCRIPTION="quake1 utilizing a hand drawn engine"
HOMEPAGE="http://www.cs.wisc.edu/graphics/Gallery/NPRQuake/ http://www.tempestgames.com/ryan/"
SRC_URI="http://www.tempestgames.com/ryan/downloads/NPRQuake-SDL.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/libsdl"

S=${WORKDIR}/NPRQuake-SDL

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.patch
	sed -i "s:GENTOO_CFLAGS:${CFLAGS}:" Makefile NPRQuakeSrc/Makefile
	echo "#define GENTOO_LIBDIR \"${GAMES_LIBDIR}/${PN}\"" >> NPRQuakeSrc/quakedef.h
}

src_compile() {
	make release || die
}

src_install() {
	newgamesbin NPRQuakeSrc/release*/bin/* nprquake-sdl
	dodir ${GAMES_LIBDIR}/${PN}
	cp -r build/* ${D}/${GAMES_LIBDIR}/${PN}/
	cd ${GAMES_LIBDIR}/${PN}
	mv dr_default.so default.so
	ln -s sketch.so dr_default.so
	dodoc README CHANGELOG
	prepgamesdirs
}
