# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/nprquake-sdl/nprquake-sdl-1-r1.ebuild,v 1.3 2004/02/20 06:40:07 mr_bones_ Exp $

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
}

src_compile() {
	make \
		GENTOO_LIBDIR="${GAMES_LIBDIR}/${PN}" \
		GENTOO_DATADIR="${GAMES_DATADIR}/quake-data" \
		OPTFLAGS="${CFLAGS}" \
		release \
		|| die
}

src_install() {
	dodoc README CHANGELOG
	newgamesbin NPRQuakeSrc/release*/bin/* nprquake-sdl
	dodir ${GAMES_LIBDIR}/${PN}
	cp -r build/* ${D}/${GAMES_LIBDIR}/${PN}/
	cd ${D}/${GAMES_LIBDIR}/${PN}
	mv dr_default.so default.so
	ln -s sketch.so dr_default.so
	prepgamesdirs
}
