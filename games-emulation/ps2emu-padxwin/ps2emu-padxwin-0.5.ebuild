# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-padxwin/ps2emu-padxwin-0.5.ebuild,v 1.2 2004/02/20 06:26:48 mr_bones_ Exp $

inherit games

DESCRIPTION="PSEmu2 PAD plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.5release/PADwin${PV}.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/PADwin

src_unpack() {
	unpack ${A}
	sed -i 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' ${S}/Src/Makefile
}

src_compile() {
	cd Src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	exeinto ${GAMES_LIBDIR}/ps2emu/plugins
	newexe Src/libPADxwin.so libPADxwin-${PV}.so
	prepgamesdirs
}
