# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/pcsx2/pcsx2-0.8.1.ebuild,v 1.7 2006/05/02 21:53:46 tupone Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Playstation2 emulator"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/${P}src.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	=x11-libs/gtk+-1*
	|| (
		>=games-emulation/ps2emu-cddvdlinuz-0.3-r1
		>=games-emulation/ps2emu-cdvdiso-0.3 )
	>=games-emulation/ps2emu-gssoft-0.6.1
	>=games-emulation/ps2emu-padxwin-0.5
	>=games-emulation/ps2emu-spu2null-0.2.1
	>=games-emulation/ps2emu-dev9null-0.1
	>=games-emulation/ps2emu-usbnull-0.4"
DEPEND="${RDEPEND}
	app-arch/p7zip"

S=${WORKDIR}/${P}src

src_unpack() {
	7z x "${DISTDIR}/${P}src.7z" || die "unpack failed"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-amd64.patch \
		"${FILESDIR}/${P}"-gcc41.patch
	sed -i \
		-e '/^CC/d' \
		-e "/^CPU/s:=.*:=$(tc-arch-kernel):" \
		Linux/Makefile \
		|| die "sed failed"
	sed -i \
		-e "/non_linear_quantizer_scale/s/^/extern /" \
		IPU/Mpeg.h \
		|| die "sed failed"
}

src_compile() {
	emake -C Linux OPTIMIZE="${CFLAGS}" || die "emake failed"
}

src_install() {
	newgamesbin Linux/pcsx2 pcsx2.bin || die "newgamesbin failed"
	dogamesbin "${FILESDIR}/pcsx2" || die "dogamesbin failed"
	sed -i \
		-e "s:GAMES_BINDIR:${GAMES_BINDIR}:" \
		-e "s:GAMES_LIBDIR:${GAMES_LIBDIR}:" \
		"${D}/${GAMES_BINDIR}/pcsx2" \
		|| die "sed failed"
	dodoc Docs/*.txt
	doicon "${FILESDIR}"/pcsx2.png
	make_desktop_entry pcsx2 PCSX2 pcsx2.png
	prepgamesdirs
}
