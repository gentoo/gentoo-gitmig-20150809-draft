# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-peopssoftgpu/psemu-peopssoftgpu-1.15.ebuild,v 1.7 2004/08/15 06:31:49 vapier Exp $

inherit games eutils

DESCRIPTION="P.E.Op.S Software GPU plugin"
HOMEPAGE="http://sourceforge.net/projects/peops/"
SRC_URI="mirror://sourceforge/peops/PeopsSoftGpu${PV//.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="sdl"

DEPEND="=x11-libs/gtk+-1*
	dev-util/pkgconfig
	sdl? ( media-libs/libsdl )
	virtual/x11
	x86? ( dev-lang/nasm )
	amd64? ( dev-lang/nasm )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-makefile-cflags.patch

	if [ "${ARCH}" != "x86" ] ; then
		cd src
		sed -i -e "s/^CPU = i386/CPU = ${ARCH}/g" makes/mk.x11
		sed -i \
			-e "s/OBJECTS.*i386.o//g" \
			-e "s/-D__i386__//g" makes/mk.fpse
		sed -i -e '/^XF86VM =/s:TRUE:FALSE:' makes/mk.x11
	fi
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die "x11 build failed"

	if use sdl ; then
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
	doexe libgpuPeops* || die
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe cfgPeopsSoft || die
	prepgamesdirs
}
