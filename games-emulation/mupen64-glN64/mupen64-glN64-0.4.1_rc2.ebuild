# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-glN64/mupen64-glN64-0.4.1_rc2.ebuild,v 1.1 2005/01/06 04:29:40 morfic Exp $

inherit games

MY_P="glN64-${PV/_/-}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="An OpenGL graphics plugin for the mupen64 N64 emulator"
SRC_URI="mirror://gentoo/glN64-0.4.1-rc2.tar.bz2"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"

KEYWORDS="x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND="media-libs/libsdl"

src_compile () {
	epatch ${FILESDIR}/${PN}-compile.patch || die "patch failed"

	if use x86; then
		if use asm; then
			einfo "using x86 asm where aviable"
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
