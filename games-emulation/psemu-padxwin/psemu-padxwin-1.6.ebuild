# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-padxwin/psemu-padxwin-1.6.ebuild,v 1.2 2004/02/13 15:42:32 dholm Exp $

inherit games eutils

DESCRIPTION="PSEmu plugin to use the keyboard as a gamepad"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/padXwin-${PV}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-makefile-cflags.patch
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	cd src
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe libpadXwin-*
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe cfgPadXwin
	prepgamesdirs
}
