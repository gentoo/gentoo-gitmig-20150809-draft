# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-cddvdlinuz/ps2emu-cddvdlinuz-0.3-r1.ebuild,v 1.6 2004/11/03 00:16:55 vapier Exp $

inherit games

DESCRIPTION="PSEmu2 CD/DVD plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.5release/CDVDlinuz${PV}.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/CDVDlinuz"

src_unpack() {
	unpack ${A}
	sed -i \
		-e 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' ${S}/Src/Makefile \
		|| die "sed failed"
}

src_compile() {
	cd Src
	emake OPTFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodoc ReadMe.txt
	exeinto ${GAMES_LIBDIR}/ps2emu/plugins
	newexe Src/libCDVDlinuz.so libCDVDlinuz-${PV}.so
	prepgamesdirs
}
