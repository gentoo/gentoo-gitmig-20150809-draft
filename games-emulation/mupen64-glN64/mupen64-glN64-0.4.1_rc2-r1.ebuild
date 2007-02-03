# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-glN64/mupen64-glN64-0.4.1_rc2-r1.ebuild,v 1.8 2007/02/03 15:53:22 blubb Exp $

inherit eutils games

MY_P="glN64-${PV/_/-}"
DESCRIPTION="An OpenGL graphics plugin for the mupen64 N64 emulator"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-amd64 x86"
IUSE="asm"

RDEPEND="media-libs/libsdl
	=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-compile.patch \
		"${FILESDIR}"/${PN}-gtk2.patch \
		"${FILESDIR}"/${PN}-ucode.patch \
		"${FILESDIR}"/${PN}-noasmfix.patch

	if ! use asm; then
		epatch ${FILESDIR}/${PN}-noasm.patch
	fi

	sed -i \
		-e "s:CXXFLAGS.*=\(.*\):CXXFLAGS=\1 -fPIC ${CXXFLAGS}:" \
		Makefile \
		|| die "sed failed"
}

src_install () {
	exeinto "${GAMES_LIBDIR}"/mupen64/plugins
	doexe glN64-0.4.1.so || die "doexe failed"
	prepgamesdirs
}
