# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/tenebrae/tenebrae-1.04.ebuild,v 1.7 2004/12/25 05:39:35 vapier Exp $

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
	if [[ -z ${ECVS_MODULE} ]] ; then
		unpack ${A}
	else
		cvs_src_unpack
	fi
	cd tenebrae_0
	epatch ${FILESDIR}/${PV}-glhax.patch
	cd linux
	sed "s:-mpentiumpro -O6:${CFLAGS}:" Makefile.i386linux > Makefile
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
	newgamesbin tenebrae_0/linux/release*/bin/tenebrae.run tenebrae || die "newgamesbin"
	insinto ${GAMES_DATADIR}/quake-data/tenebrae
	doins ${WORKDIR}/tenebrae/* || die "doins data"
	dodoc tenebrae_0/linux/README ${WORKDIR}/Tenebrae_Readme.txt
	prepgamesdirs
}
