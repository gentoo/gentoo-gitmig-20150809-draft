# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/epsxe/epsxe-1.6.0-r3.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games

DESCRIPTION="ePSXe Playstation Emulator"
HOMEPAGE="http://www.epsxe.com/"
SRC_URI="http://download.epsxe.com/files/epsxe${PV//.}lin.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="-* x86"
IUSE="opengl"
RESTRICT="nostrip" # For some strange reason, strip truncates the whole file

DEPEND="app-arch/unzip"
RDEPEND=">=dev-libs/glib-1.2
	=x11-libs/gtk+-1.2*
	=sys-libs/ncurses-5*
	=sys-libs/zlib-1*
	net-misc/wget
	games-emulation/psemu-peopsspu
	|| (
		opengl? ( games-emulation/psemu-gpupetemesagl )
		games-emulation/psemu-peopssoftgpu
	)"

S=${WORKDIR}

src_install() {
	dogamesbin ${FILESDIR}/epsxe
	exeinto ${GAMES_PREFIX_OPT}/${PN}
	doexe epsxe
	insinto ${GAMES_PREFIX_OPT}/${PN}
	doins keycodes.lst

	insinto ${GAMES_LIBDIR}/psemu/cheats
	doins cheats/*

	dodoc docs/*

	prepgamesdirs
}
