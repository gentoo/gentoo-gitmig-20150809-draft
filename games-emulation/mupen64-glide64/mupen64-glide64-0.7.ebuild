# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-glide64/mupen64-glide64-0.7.ebuild,v 1.5 2005/01/31 03:27:18 mr_bones_ Exp $

inherit flag-o-matic eutils games

DESCRIPTION="An opengl graphics plugin for the mupen64 N64 emulator"
HOMEPAGE="http://mupen64.emulation64.com/"
SRC_URI="mirror://gentoo/glide64_0_7_ME.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk2"

DEPEND=""

S="${WORKDIR}/glide64_0_7_ME"

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/${P}-compile.patch || die "patch failed"
	epatch ${FILESDIR}/${P}-inifix.patch || die "patch failed"
	use gtk2 && epatch ${FILESDIR}/${P}-gtk2.patch || die "patch failed"

	make clean || die "couldn't clean"

	# gcc 3.4 at least has a problem with -O3 and inline asm
	replace-flags -O3 -O2
	sed -i -e "s:CFLAGS.*=\(.*\):CFLAGS=\1 ${CFLAGS}:" Makefile ||  \
		die "couldn't apply cflags"

}

src_compile() {
	# doesnt like -j2
	make || die "couldn't compile"
}

src_install() {
	exeinto "${GAMES_LIBDIR}/mupen64/plugins"
	doexe Glide64.so || die "doexe failed"
	insinto "${GAMES_LIBDIR}/mupen64/plugins"
	doins Glide64.ini
	prepgamesdirs
}
