# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fbzx/fbzx-1.4.ebuild,v 1.2 2004/04/22 10:06:02 mr_bones_ Exp $

inherit games

S="${WORKDIR}/${PN}"
DESCRIPTION="A Sinclair Spectrum emulator, designed to work at full screen using the FrameBuffer"
HOMEPAGE="http://www.rastersoft.com/fbzx.html"
SRC_URI="http://www.rastersoft.com/programas/fbzx/${PN}14.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"
IUSE=""

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s|/usr/share/spectrum|${GAMES_DATADIR}/${PN}|g" emulator.c \
			|| die "sed failed"
}

src_install () {
	dogamesbin fbzx || die "dogamesbin failed"
	insinto /usr/share/fbzx/roms
	doins roms/* || die "doins failed"
	dodoc CAPABILITIES FAQ INSTALL PORTS README* TODO VERSIONS
	prepgamesdirs
}
