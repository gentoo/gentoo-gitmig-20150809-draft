# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/anaglyph-stereo-quake/anaglyph-stereo-quake-130100.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games gcc eutils

DESCRIPTION="play Quake in 3D with red - blue glasses"
HOMEPAGE="http://home.iprimus.com.au/crbean/"
SRC_URI="http://home.iprimus.com.au/crbean/zip/3dGLQuake_SRC_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/opengl"

S=${WORKDIR}/WinQuake

src_unpack() {
	unpack ${A}

	cd ${S}
	mv GLQUAKE.H glquake.h
	mv GL_DRAW.C gl_draw.c
	mv GL_RMAIN.C gl_rmain.c
	epatch ${FILESDIR}/stupid-dosformat.patch

	epatch ${FILESDIR}/fix-sys_printf.patch

	mv Makefile{.linuxi386,}
	epatch ${FILESDIR}/makefile-path-fixes.patch

	[ `gcc-major-version` -eq 3 ] \
		&& epatch ${FILESDIR}/makefile-gcc3-cflags.patch \
		|| epatch ${FILESDIR}/makefile-gcc2-cflags.patch
	sed -i "s:GENTOO_CFLAGS:${CFLAGS} -DGL_EXT_SHARED=1:" Makefile

	epatch ${FILESDIR}/makefile-onlyglx.patch
}

src_compile() {
	make build_release || die "failed to build WinQuake"
}

src_install() {
	newgamesbin release*/bin/glquake.glx anaglyph-stereo-quake
	dodoc ${WORKDIR}/readme.id.txt
	dohtml ${WORKDIR}/3dquake.html
	prepgamesdirs
}
