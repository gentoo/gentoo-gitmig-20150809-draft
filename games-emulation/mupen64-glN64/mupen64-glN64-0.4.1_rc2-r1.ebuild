# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-glN64/mupen64-glN64-0.4.1_rc2-r1.ebuild,v 1.3 2005/04/17 17:10:26 morfic Exp $

inherit eutils games

MY_P="glN64-${PV/_/-}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="An OpenGL graphics plugin for the mupen64 N64 emulator"
SRC_URI="mirror://gentoo/glN64-0.4.1-rc2.tar.bz2"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"

KEYWORDS="x86"
LICENSE="as-is"
SLOT="0"
IUSE="asm"

RDEPEND="media-libs/libsdl"

src_compile () {
	epatch ${FILESDIR}/${PN}-compile.patch || die "icompile patch failed"
	epatch ${FILESDIR}/${PN}-gtk2.patch || die "gtk2 patch failed"
	epatch ${FILESDIR}/${PN}-ucode.patch || die "ucode patch failed"
	if use x86; then
		if use asm; then
			einfo "using x86 asm where available"
		else
			epatch ${FILESDIR}/${PN}-noasm.patch
		fi
	fi

	sed -i -e "s:CXXFLAGS.*=\(.*\):CXXFLAGS=\1 ${CXXFLAGS}:" Makefile ||  \
		die "couldn't apply cflags"
	make || die
}

src_install () {
	exeinto ${GAMES_LIBDIR}/mupen64/plugins
	doexe glN64-0.4.1.so || die "doexe failed"
	prepgamesdirs
}
