# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fbzx/fbzx-1.4.ebuild,v 1.7 2005/06/15 18:33:32 wolf31o2 Exp $

inherit games eutils toolchain-funcs

DESCRIPTION="A Sinclair Spectrum emulator, designed to work at full screen using the FrameBuffer"
HOMEPAGE="http://www.rastersoft.com/fbzx.html"
SRC_URI="http://www.rastersoft.com/programas/fbzx/${PN}14.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s|/usr/share/spectrum|${GAMES_DATADIR}/${PN}|g" \
		emulator.c || die "sed failed"
	sed -i \
		-e "s:gcc:$(tc-getCC):" \
		-e "s:-O2:${CFLAGS}:" \
		Makefile
	epatch ${FILESDIR}/${PV}-endian.patch
}

src_install() {
	dogamesbin fbzx || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}/roms"
	doins roms/* || die "doins failed"
	dodoc CAPABILITIES FAQ PORTS README* TODO VERSIONS
	prepgamesdirs
}
