# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ps2emu-gssoft/ps2emu-gssoft-0.5.ebuild,v 1.1 2003/08/15 01:26:15 vapier Exp $

inherit games

DESCRIPTION="PSEmu2 GPU plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.4release/Gssoft-${PV}.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/opengl
	virtual/x11"
#	sdl? ( media-libs/libsdl )"

S=${WORKDIR}/GSsoft-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile.patch
}

src_compile() {
	cd Src/Linux
	emake OPTFLAGS="${CFLAGS}" || die "building X"
	mv lib* ${S}/
	#requires stuff from nSX2 which atm is win32 only
	#if [ `use sdl` ] ; then
	#	cd ..
	#	ln -s GS.h gs.h
	#	epatch ${FILESDIR}/${PV}-sdl.patch
	#	mv Linux-SDL/* Linux/
	#	cd Linux
	#	make clean || die "making clean"
	#	emake OPTFLAGS="${CFLAGS}" || die "building sdl"
	#fi
}

src_install() {
	dodoc ReadMe.txt
	exeinto ${GAMES_LIBDIR}/ps2emu/plugins
	doexe lib*
	prepgamesdirs
}
