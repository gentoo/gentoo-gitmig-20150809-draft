# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-spu2null/ps2emu-spu2null-0.4.ebuild,v 1.3 2007/04/09 15:52:52 nyhm Exp $

inherit games

DESCRIPTION="PSEmu2 NULL Sound plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/SPU2null${PV//.}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/SPU2null${PV//.}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' Src/Makefile || die
}

src_compile() {
	cd Src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	exeinto "$(games_get_libdir)"/ps2emu/plugins
	newexe Src/libSPU2null.so libSPU2null-${PV//.}.so || die
	prepgamesdirs
}
