# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-peopssoftgpu/psemu-peopssoftgpu-1.15.ebuild,v 1.1 2003/09/09 16:26:50 vapier Exp $

inherit games eutils

DESCRIPTION="P.E.Op.S Software GPU plugin"
HOMEPAGE="http://sourceforge.net/projects/peops/"
SRC_URI="mirror://sourceforge/peops/PeopsSoftGpu${PV//.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE="sdl"

DEPEND="=x11-libs/gtk+-1*
	dev-util/pkgconfig
	sdl? ( media-libs/libsdl )
	virtual/x11
	dev-lang/nasm"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-makefile-cflags.patch
}

src_compile() {
	cd src

	emake OPTFLAGS="${CFLAGS}" || die "x11 build failed"

	if [ `use sdl` ] ; then
		sed -i 's:mk.x11:mk.fpse:g' Makefile
		make clean || die "make clean failed"
		emake OPTFLAGS="${CFLAGS}" || die "sdl build failed"
	fi
}

src_install() {
	dodoc *.txt
	insinto ${GAMES_LIBDIR}/psemu/cfg
	doins gpuPeopsSoftX.cfg
	cd src
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe libgpuPeops*
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe cfgPeopsSoft
	prepgamesdirs
}
