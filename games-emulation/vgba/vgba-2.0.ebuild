# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/vgba/vgba-2.0.ebuild,v 1.1 2003/09/09 16:26:50 vapier Exp $

inherit games

DESCRIPTION="emulator of the GameBoy Advance"
HOMEPAGE="http://www.komkon.org/fms/VGBA/"
SRC_URI="http://fms.komkon.org/VGBA/VGBA${PV/.}-Linux-80x86-bin.tar.Z"

LICENSE="VGBA"
SLOT="0"
KEYWORDS="-* x86"

RDEPEND="virtual/x11"

S=${WORKDIR}

src_install() {
	dogamesbin vgba
	dohtml VGBA.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "You must run X in 16bit color for the emu to work"
}
