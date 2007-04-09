# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-gssoft/ps2emu-gssoft-0.9.ebuild,v 1.7 2007/04/09 15:49:33 nyhm Exp $

inherit eutils games

DESCRIPTION="PSEmu2 GPU plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/GSsoft${PV}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	media-libs/libsdl
	=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/GSsoft${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		's:-O2 -fomit-frame-pointer -ffast-math:$(OPTFLAGS):' \
		Src/Linux/Makefile \
		|| die "sed failed"
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-PIC.patch \
		"${FILESDIR}/${P}"-gcc41.patch
}

src_compile() {
	cd Src/Linux
	emake OPTFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodoc ReadMe.txt
	exeinto "$(games_get_libdir)"/ps2emu/plugins
	newexe Src/Linux/libGSsoft.so libGSsoft-${PV}.so || die "newexe failed"
	prepgamesdirs
}
