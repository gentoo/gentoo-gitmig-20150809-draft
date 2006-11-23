# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-padjoy/psemu-padjoy-0.82.ebuild,v 1.6 2006/11/23 22:17:48 nyhm Exp $

inherit games

DESCRIPTION="PSEmu plugin to use joysticks/gamepads in PSX-emulators"
HOMEPAGE="http://www.ammoq.com/"
SRC_URI="http://members.chello.at/erich.kitzmueller/ammoq/padJoy${PV//.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/padJoy/src

src_unpack() {
	unpack ${A}
	cd "${S}"
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
