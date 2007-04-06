# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/epsxe/epsxe-1.6.0-r3.ebuild,v 1.11 2007/04/06 04:38:00 nyhm Exp $

inherit games

DESCRIPTION="ePSXe PlayStation Emulator"
HOMEPAGE="http://www.epsxe.com/"
SRC_URI="http://www.epsxe.com/files/epsxe${PV//.}lin.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="-* x86"
IUSE="opengl"
RESTRICT="strip"

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	app-arch/unzip"
RDEPEND="${RDEPEND}
	x11-misc/imake
	games-emulation/psemu-peopsspu
	opengl? ( games-emulation/psemu-gpupetemesagl )
	!opengl? ( games-emulation/psemu-peopssoftgpu )"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dogamesbin "${FILESDIR}"/epsxe
	sed -i \
		-e "s:GAMES_PREFIX_OPT:${GAMES_PREFIX_OPT}:" \
		-e "s:GAMES_LIBDIR:$(games_get_libdir):" \
		"${D}${GAMES_BINDIR}"/epsxe \
		|| die "sed failed"
	exeinto "${dir}"
	doexe epsxe || die "doexe failed"
	insinto "${dir}"
	doins keycodes.lst || die "doins failed"
	insinto "$(games_get_libdir)"/psemu/cheats
	doins cheats/* || die "doins failed"
	dodoc docs/*
	prepgamesdirs
}
