# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/pcsx2/pcsx2-0.5.ebuild,v 1.4 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Playstation2 emulator"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/${PV:0:3}release/Pcsx2Src-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/x11
	=x11-libs/gtk+-1*
	|| (
		>=games-emulation/ps2emu-cddvdlinuz-0.3-r1
		>=games-emulation/ps2emu-cdvdiso-0.3
	)
	>=games-emulation/ps2emu-gssoft-0.61
	>=games-emulation/ps2emu-padxwin-0.5
	>=games-emulation/ps2emu-spu2null-0.21
	>=games-emulation/ps2emu-dev9null-0.1"
DEPEND="${RDEPEND}
	dev-lang/nasm"

S=${WORKDIR}/Pcsx2Src-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-time-renames.patch
}

src_compile() {
	cd ${S}/ix86-32/GoldRec
	emake OPTIMIZE="${CFLAGS}" || die "goldrec building failed"
	cd ${S}/Linux
	emake OPTIMIZE="${CFLAGS}" || die "linux building failed"
}

src_install() {
	newgamesbin Linux/pcsx2 pcsx2.bin
	dogamesbin ${FILESDIR}/pcsx2
	dodir ${GAMES_LIBDIR}/ps2emu/Langs
	rm -rf Intl/Langs/cvs
	cp -r Intl/Langs/* ${D}/${GAMES_LIBDIR}/ps2emu/Langs/
	dodoc Docs/*.txt
	prepgamesdirs
}
