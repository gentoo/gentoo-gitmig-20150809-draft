# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-cdvdiso/ps2emu-cdvdiso-0.2.ebuild,v 1.1 2003/09/09 16:26:50 vapier Exp $

inherit games

DESCRIPTION="PSEmu2 CD/DVD iso plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.4release/CDVDiso-${PV}.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/CDVDiso

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile.patch
}

src_compile() {
	cd src/Linux
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	cd src/Linux
	exeinto ${GAMES_LIBDIR}/ps2emu/plugins
	doexe lib*
	exeinto ${GAMES_LIBDIR}/ps2emu/cfg
	doexe cfgCDVDiso
	prepgamesdirs
}
