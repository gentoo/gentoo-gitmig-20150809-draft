# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-usbnull/ps2emu-usbnull-0.4.ebuild,v 1.4 2007/04/09 15:54:33 nyhm Exp $

inherit games

DESCRIPTION="PSEmu2 NULL USB plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/USBnull${PV//.}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/USBnull${PV//.}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:-O3 -fomit-frame-pointer:$(OPTFLAGS):' \
		-e '/strip/d' \
		Linux/Makefile || die
}

src_compile() {
	cd Linux
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	exeinto "$(games_get_libdir)"/ps2emu/plugins
	newexe Linux/libUSBnull.so libUSBnull-${PV//.}.so || die
	exeinto "$(games_get_libdir)"/ps2emu/cfg
	doexe Linux/cfgUSBnull || die
	prepgamesdirs
}
