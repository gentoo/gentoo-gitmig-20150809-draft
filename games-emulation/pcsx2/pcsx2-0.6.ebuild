# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/pcsx2/pcsx2-0.6.ebuild,v 1.3 2004/11/03 00:16:33 vapier Exp $

inherit eutils games

DESCRIPTION="Playstation2 emulator"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/${PV}release/pcsx2_${PV}src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

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
	app-arch/unzip
	dev-lang/nasm"

S="${WORKDIR}/pcsx2_${PV}src"

src_unpack() {
	unpack ${A}
	cd ${S}
	find . -name CVS -type d -print0 | xargs -0 rm -rf
}
src_compile() {
	cd "${S}/ix86-32/GoldRec"
	emake OPTIMIZE="${CFLAGS}" || die "goldrec building failed"
	cd "${S}/Linux"
	emake OPTIMIZE="${CFLAGS}" || die "linux building failed"
}

src_install() {
	newgamesbin Linux/pcsx2 pcsx2.bin || die "newgamesbin failed"
	dogamesbin "${FILESDIR}/pcsx2" || die "dogamesbin failed"
	dodir "${GAMES_LIBDIR}/ps2emu/Langs"
	cp -r Intl/Langs/* "${D}/${GAMES_LIBDIR}/ps2emu/Langs/" || die "cp failed"
	dodoc Docs/*.txt
	prepgamesdirs
}
