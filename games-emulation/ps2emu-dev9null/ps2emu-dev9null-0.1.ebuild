# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-dev9null/ps2emu-dev9null-0.1.ebuild,v 1.2 2004/02/20 06:26:48 mr_bones_ Exp $

inherit games

DESCRIPTION="PSEmu2 NULL Sound plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.5release/dev9null${PV}.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/dev9null

src_unpack() {
	unpack ${A}
	sed -i 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' ${S}/src/Makefile
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	exeinto ${GAMES_LIBDIR}/ps2emu/plugins
	newexe src/libDEV9null.so libDEV9null-${PV}.so
	prepgamesdirs
}
