# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-glN64/mupen64-glN64-0.4.1_rc2-r1.ebuild,v 1.5 2005/04/24 20:04:08 morfic Exp $

inherit eutils games

MY_P="glN64-${PV/_/-}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="An OpenGL graphics plugin for the mupen64 N64 emulator"
SRC_URI="mirror://gentoo/glN64-0.4.1-rc2.tar.bz2"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"

KEYWORDS="x86 ~amd64"
LICENSE="as-is"
SLOT="0"
IUSE="asm gtk2"

RDEPEND="media-libs/libsdl
	!gtk2? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )"
DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )"

src_compile () {
	epatch ${FILESDIR}/${PN}-compile.patch || die "compile patch failed"

	if use gtk2; then
		epatch ${FILESDIR}/${PN}-gtk2.patch || die "gtk2 patch failed"
	fi

	epatch ${FILESDIR}/${PN}-ucode.patch || die "ucode patch failed"
	epatch ${FILESDIR}/${PN}-noasmfix.patch || die "noasmfix patch failed"

	if ! use asm; then
		epatch ${FILESDIR}/${PN}-noasm.patch
	fi

	sed -i -e "s:CXXFLAGS.*=\(.*\):CXXFLAGS=\1 -fPIC ${CXXFLAGS}:" \
		Makefile || die "couldn't apply cflags"

	make || die
}

src_install () {
	exeinto ${GAMES_LIBDIR}/mupen64/plugins
	doexe glN64-0.4.1.so || die "doexe failed"
	prepgamesdirs
}
