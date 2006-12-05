# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/tenebrae/tenebrae-1.04.ebuild,v 1.11 2006/12/05 18:02:09 wolf31o2 Exp $

#ECVS_SERVER="cvs.tenebrae.sourceforge.net:/cvsroot/tenebrae"
#ECVS_MODULE="tenebrae_0"
#inherit cvs
inherit eutils games

DESCRIPTION="adds stencil shadows and per pixel lights to quake"
HOMEPAGE="http://tenebrae.sourceforge.net/"
SRC_URI="mirror://sourceforge/tenebrae/tenebraedata.zip
	mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libpng
	x11-libs/libXxf86vm
	x11-libs/libXxf86dga"
#	sdl? ( media-libs/libsdl )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	if [[ -z ${ECVS_MODULE} ]] ; then
		unpack ${A}
	else
		cvs_src_unpack
	fi
	cd tenebrae_0
	epatch "${FILESDIR}"/${PV}-glhax.patch
	cd linux
	sed "s:-mpentiumpro -O6:${CFLAGS}:" Makefile.i386linux > Makefile
	#if use sdl ; then
	#	cd ../sdl
	#	./autogen.sh
	#fi
}

src_compile() {
	cd "${S}"/tenebrae_0/linux
	make MASTER_DIR="${GAMES_DATADIR}/quake1" build_release || die
	#if use sdl ; then
	#	cd ${S}/tenebrae_0/sdl
	#	egamesconf || die
	#	make || die
	#fi
}

src_install() {
	newgamesbin tenebrae_0/linux/release*/bin/tenebrae.run tenebrae || die "newgamesbin"
	insinto "${GAMES_DATADIR}/quake1/tenebrae"
	doins "${WORKDIR}"/tenebrae/* || die "doins data"
	dodoc tenebrae_0/linux/README "${WORKDIR}"/Tenebrae_Readme.txt
	prepgamesdirs
}
