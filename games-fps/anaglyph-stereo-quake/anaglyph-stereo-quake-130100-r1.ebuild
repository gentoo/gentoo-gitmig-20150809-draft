# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/anaglyph-stereo-quake/anaglyph-stereo-quake-130100-r1.ebuild,v 1.3 2004/02/20 06:40:06 mr_bones_ Exp $

inherit games gcc eutils

DESCRIPTION="play Quake in 3D with red - blue glasses"
HOMEPAGE="http://home.iprimus.com.au/crbean/"
SRC_URI="http://home.iprimus.com.au/crbean/zip/3dGLQuake_SRC_${PV}.zip
	mirror://gentoo/${P}-SDL.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl"

S=${WORKDIR}/WinQuake

src_unpack() {
	unpack ${A}

	cd ${S}
	mv GLQUAKE.H glquake.h
	mv GL_DRAW.C gl_draw.c
	mv GL_RMAIN.C gl_rmain.c
	epatch ${FILESDIR}/stupid-dosformat.patch
	mv Makefile{.linuxi386,}
	epatch ${FILESDIR}/makefile-path-fixes.patch
	epatch ${FILESDIR}/fix-sys_printf.patch
	epatch ${FILESDIR}/makefile-cflags.patch
	epatch ${FILESDIR}/gentoo-paths.patch
	epatch ${WORKDIR}/${P}-SDL.patch
}

src_compile() {
	make \
		OPTFLAGS="${CFLAGS}" \
		GENTOO_DATADIR=${GAMES_DATADIR}/quake-data \
		build_release \
		|| die "failed to build WinQuake"
}

src_install() {
	newgamesbin release*/bin/glquake.sdl anaglyph-stereo-quake
	dodoc ${WORKDIR}/readme.id.txt
	dohtml ${WORKDIR}/3dquake.html
	prepgamesdirs
}
