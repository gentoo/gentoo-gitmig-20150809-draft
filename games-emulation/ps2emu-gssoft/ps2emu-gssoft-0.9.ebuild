# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-gssoft/ps2emu-gssoft-0.9.ebuild,v 1.5 2006/02/11 04:42:20 joshuabaergen Exp $

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
	unrar x -idq "${DISTDIR}"/${A} || die
	cd "${S}"
	sed -i 's:-O2 -fomit-frame-pointer -ffast-math:$(OPTFLAGS):' Src/Linux/Makefile || die
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-PIC.patch
}

src_compile() {
	cd Src/Linux
	emake OPTFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	dodoc ReadMe.txt
	exeinto "${GAMES_LIBDIR}"/ps2emu/plugins
	newexe Src/Linux/libGSsoft.so libGSsoft-${PV}.so || die
	prepgamesdirs
}
