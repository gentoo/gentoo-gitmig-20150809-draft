# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-padjoy/psemu-padjoy-0.82.ebuild,v 1.2 2004/02/13 15:57:54 dholm Exp $

inherit games eutils

S="${WORKDIR}/padJoy/src"
DESCRIPTION="PSEmu plugin to use joysticks/gamepads in PSX-emulators"
HOMEPAGE="http://www.ammoq.com/"
SRC_URI="http://members.chello.at/erich.kitzmueller/ammoq/padJoy${PV//.}.tgz"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=x11-libs/gtk+-1*
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:-O2 -fomit-frame-pointer:${CFLAGS}:" Makefile || \
			die "sed Makefile failed"
}

src_install() {
	exeinto "${GAMES_LIBDIR}/psemu/plugins"
	doexe libpadJoy-*   || die "doexe failed"
	exeinto "${GAMES_LIBDIR}/psemu/cfg"
	doexe cfgPadJoy     || die "doexe failed (2)"
	dodoc ../readme.txt || die "dodoc failed"
	prepgamesdirs
}
