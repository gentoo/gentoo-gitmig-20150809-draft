# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/tenebrae/tenebrae-1.04.ebuild,v 1.6 2004/11/03 00:28:19 vapier Exp $

#ECVS_SERVER="cvs.tenebrae.sourceforge.net:/cvsroot/tenebrae"
#ECVS_MODULE="tenebrae_0"
#inherit cvs
inherit games eutils

DESCRIPTION="adds stencil shadows and per pixel lights to quake"
HOMEPAGE="http://tenebrae.sourceforge.net/"
SRC_URI="mirror://sourceforge/tenebrae/tenebraedata.zip
	mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/x11
	media-libs/libpng
	sys-libs/zlib"
#	sdl? ( media-libs/libsdl )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	#cvs_src_unpack
	cd tenebrae_0
	local gl="`ls -al /usr/include/GL/gl.h  | awk '{print $NF}' | cut -d/ -f5`"
	[ "${gl}" == "nvidia" ] && epatch ${FILESDIR}/${PV}-nvidia-opengl.patch
	cd linux
	sed "s:-mpentiumpro:${CFLAGS}:" Makefile.i386linux > Makefile
	#if use sdl ; then
	#	cd ../sdl
	#	./autogen.sh
	#fi
}

src_compile() {
	cd ${S}/tenebrae_0/linux
	make MASTER_DIR=${GAMES_DATADIR}/quake-data build_release || die
	#if use sdl ; then
	#	cd ${S}/tenebrae_0/sdl
	#	egamesconf || die
	#	make || die
	#fi
}

src_install() {
	newgamesbin tenebrae_0/linux/release*/bin/tenebrae.run tenebrae
	insinto ${GAMES_DATADIR}/quake-data/tenebrae
	doins ${WORKDIR}/tenebrae/*
	dodoc tenebrae_0/linux/README ${WORKDIR}/Tenebrae_Readme.txt
	prepgamesdirs
}
