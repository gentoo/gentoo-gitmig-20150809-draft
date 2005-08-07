# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-padxwin/ps2emu-padxwin-0.9.ebuild,v 1.1 2005/08/07 07:23:45 vapier Exp $

inherit games

DESCRIPTION="PSEmu2 PAD plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/PADwin${PV//.}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/PADwin${PV//.}

src_unpack() {
	unrar x -idq "${DISTDIR}"/${A}
	cd "${S}"
	sed -i 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' Src/Makefile || die
}

src_compile() {
	cd Src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	exeinto "${GAMES_LIBDIR}"/ps2emu/plugins
	newexe Src/libPADwin.so libPADxwin-${PV}.so || die
	prepgamesdirs
}
