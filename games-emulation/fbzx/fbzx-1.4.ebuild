# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fbzx/fbzx-1.4.ebuild,v 1.1 2004/03/21 20:17:28 dholm Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="FBZX is a Sinclair Spectrum emulator, designed to work at full screen using the FrameBuffer."
SRC_URI="http://www.rastersoft.com/programas/fbzx/${PN}14.tar.gz"
HOMEPAGE="http://www.rastersoft.com/fbzx.html"
LICENSE="GPL-2"
DEPEND="media-libs/libsdl"
KEYWORDS="~ppc"
SLOT="0"
IUSE="sdl"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e "s|share/spectrum|share/fbzx|g" emulator.c
}

src_compile() {
	emake || die
}

src_install () {
	dobin fbzx

	dodir /usr/share/fbzx
	insinto /usr/share/fbzx/roms
	doins roms/*

	dodoc COPYING FAQ INSTALL README TODO
}
