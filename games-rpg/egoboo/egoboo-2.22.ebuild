# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/egoboo/egoboo-2.22.ebuild,v 1.14 2006/03/14 04:18:53 mr_bones_ Exp $

inherit eutils flag-o-matic toolchain-funcs games

DESCRIPTION="A 3d dungeon crawling adventure in the spirit of NetHack"
HOMEPAGE="http://egoboo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/ego${PV/./}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl"

S=${WORKDIR}/${PN}

src_unpack() {
	replace-cpu-flags 'athlon*' pentium4 i686

	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^CC=/ s:=.*:=$(tc-getCC):" \
		-e "s:-ffast-math -funroll-loops -O3 -g:${CFLAGS}:" code/Makefile \
		|| die "sed code/Makefile failed"
	sed \
		-e "s:GENTOODIR:${GAMES_DATADIR}:" "${FILESDIR}/${P}.sh" \
		> "${T}/egoboo" || die "sed wrapper failed"

	# Fix endianess using SDL
	epatch ${FILESDIR}/${PV}-endian.patch
}

src_compile() {
	cd code
	make clean || die "make clean failed"
	emake egoboo || die "emake failed"
}

src_install () {
	dogamesbin "${T}/egoboo" || die "dogamesbin failed"
	dodoc egoboo.txt
	dodir "${GAMES_DATADIR}/${PN}" "${GAMES_BINDIR}"
	cp -R basicdat/ import/ modules/ players/ text/ \
		code/egoboo controls.txt setup.txt \
		"${D}${GAMES_DATADIR}/${PN}" || die "cp failed"

	prepgamesdirs
	# ugly, but the game needs write here.
	cd "${D}${GAMES_DATADIR}/${PN}"
	chmod -R g+w setup.txt basicdat players import
}
