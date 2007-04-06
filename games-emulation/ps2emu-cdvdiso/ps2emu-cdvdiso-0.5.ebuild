# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-cdvdiso/ps2emu-cdvdiso-0.5.ebuild,v 1.5 2007/04/06 19:53:05 nyhm Exp $

inherit eutils games

DESCRIPTION="PSEmu2 CD/DVD iso plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/CDVDiso${PV//.}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/CDVDiso${PV//.}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' \
		-e '/strip/d' \
		src/Linux/Makefile || die
	epatch "${FILESDIR}/${P}"-gcc41.patch
}

src_compile() {
	cd src/Linux
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	cd src/Linux
	exeinto "$(games_get_libdir)"/ps2emu/plugins
	newexe libCDVDiso.so libCDVDiso-${PV}.so || die
	exeinto "$(games_get_libdir)"/ps2emu/cfg
	doexe cfgCDVDiso || die
	prepgamesdirs
}
