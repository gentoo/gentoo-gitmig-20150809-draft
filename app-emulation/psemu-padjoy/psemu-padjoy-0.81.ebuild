# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-padjoy/psemu-padjoy-0.81.ebuild,v 1.1 2003/08/14 06:25:09 vapier Exp $

inherit games eutils

DESCRIPTION="PSEmu plugin to use joysticks/gamepads in PSX-emulators"
HOMEPAGE="http://www.ammoq.com/"
SRC_URI="http://members.chello.at/erich.kitzmueller/ammoq/padJoy${PV//.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/padJoy

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile-cflags.patch
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc readme.txt
	cd src
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe libpadJoy-*
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe cfgPadJoy
	prepgamesdirs
}
