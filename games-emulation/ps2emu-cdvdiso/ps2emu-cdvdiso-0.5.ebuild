# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-cdvdiso/ps2emu-cdvdiso-0.5.ebuild,v 1.1 2005/08/07 07:20:16 vapier Exp $

inherit games

DESCRIPTION="PSEmu2 CD/DVD iso plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/CDVDiso${PV//.}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/CDVDiso${PV//.}

src_unpack() {
	unrar x -idq "${DISTDIR}"/${A}
	cd "${S}"
	sed -i 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' src/Linux/Makefile || die
}

src_compile() {
	cd src/Linux
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	cd src/Linux
	exeinto "${GAMES_LIBDIR}"/ps2emu/plugins
	newexe libCDVDiso.so libCDVDiso-${PV}.so || die
	exeinto "${GAMES_LIBDIR}"/ps2emu/cfg
	doexe cfgCDVDiso || die
	prepgamesdirs
}
