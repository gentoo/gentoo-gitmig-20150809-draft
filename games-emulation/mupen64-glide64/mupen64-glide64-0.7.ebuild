# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-glide64/mupen64-glide64-0.7.ebuild,v 1.1 2005/01/03 15:36:18 morfic Exp $

inherit games

DESCRIPTION="An opengl graphics plugin for the mupen64 N64 emulator"
HOMEPAGE="http://mupen64.emulation64.com/"
SRC_URI="mirror://gentoo/glide64_0_7_ME.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S="${WORKDIR}/glide64_0_7_ME"

src_compile() {
	epatch ${FILESDIR}/${P}-compile.patch || die "patch failed"
	use gtk2 && epatch ${FILESDIR}/${P}-gtk2.patch || die "patch failed"

	make clean || die "couldn't clean"
	sed -i -e "s:CFLAGS.*=\(.*\):CFLAGS=\1 ${CFLAGS}:" Makefile ||  \
		die "couldn't apply cflags"
	make || die "couldn't compile"
}

src_install() {
	exeinto "${GAMES_LIBDIR}/mupen64/plugins"
	doexe Glide64.so || die "doexe failed"
	insinto "${GAMES_LIBDIR}/mupen64/plugins"
	doins Glide64.ini
	prepgamesdirs
}
