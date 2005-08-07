# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-usbnull/ps2emu-usbnull-0.4.ebuild,v 1.2 2005/08/07 07:36:26 vapier Exp $

inherit games

DESCRIPTION="PSEmu2 NULL USB plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/USBnull${PV//.}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/USBnull${PV//.}

src_unpack() {
	unrar x -idq "${DISTDIR}"/${A} || die
	cd "${S}"
	sed -i 's:-O3 -fomit-frame-pointer:$(OPTFLAGS):' Linux/Makefile || die
}

src_compile() {
	cd Linux
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	exeinto "${GAMES_LIBDIR}"/ps2emu/plugins
	newexe Linux/libUSBnull.so libUSBnull-${PV//.}.so || die
	exeinto "${GAMES_LIBDIR}"/ps2emu/cfg
	doexe Linux/cfgUSBnull || die
	prepgamesdirs
}
