# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-padjoy/psemu-padjoy-0.82.ebuild,v 1.3 2004/03/24 06:53:24 mr_bones_ Exp $

inherit games

S="${WORKDIR}/padJoy/src"
DESCRIPTION="PSEmu plugin to use joysticks/gamepads in PSX-emulators"
HOMEPAGE="http://www.ammoq.com/"
SRC_URI="http://members.chello.at/erich.kitzmueller/ammoq/padJoy${PV//.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:-O2 -fomit-frame-pointer:${CFLAGS}:" Makefile \
			|| die "sed Makefile failed"
}

src_install() {
	exeinto "${GAMES_LIBDIR}/psemu/plugins"
	doexe libpadJoy-*   || die "doexe failed"
	exeinto "${GAMES_LIBDIR}/psemu/cfg"
	doexe cfgPadJoy     || die "doexe failed (2)"
	dodoc ../readme.txt || die "dodoc failed"
	prepgamesdirs
}
