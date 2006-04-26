# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/egoboo/egoboo-2.22.ebuild,v 1.17 2006/04/26 06:49:38 mr_bones_ Exp $

inherit eutils flag-o-matic toolchain-funcs games

DESCRIPTION="A 3d dungeon crawling adventure in the spirit of NetHack"
HOMEPAGE="http://egoboo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/ego${PV/./}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl"

S=${WORKDIR}/${PN}

src_unpack() {
	use !amd64 && replace-cpu-flags 'athlon*' pentium4 i686

	unpack ${A}
	cd "${S}"

	# Fix endianess using SDL
	# amd64 patch must be applied after ${PV}-endian.patch
	# this addresses bug #104271
	epatch \
		${FILESDIR}/${PV}-endian.patch \
		${FILESDIR}/${PV}-amd64.patch
}

src_compile() {
	cd code
	make clean || die "make clean failed"
	emake FLAGS="-D_LINUX ${CFLAGS}" CC="$(tc-getCC)" egoboo || die "emake failed"
}

src_install () {
	games_make_wrapper ${PN} ./${PN} "${GAMES_DATADIR}/${PN}"
	dodoc egoboo.txt
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r basicdat/ import/ modules/ players/ text/ \
		code/egoboo controls.txt setup.txt \
		|| die "doins failed"
	# FIXME: this is stupid.  should be patched to run out of GAMES_BINDIR
	fperms 750 "${GAMES_DATADIR}/${PN}/${PN}"

	prepgamesdirs
	# ugly, but the game needs write here.
	cd "${D}${GAMES_DATADIR}/${PN}"
	chmod -R g+w setup.txt basicdat players import
}
