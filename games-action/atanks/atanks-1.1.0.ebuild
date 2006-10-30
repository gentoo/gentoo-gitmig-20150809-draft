# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/atanks/atanks-1.1.0.ebuild,v 1.17 2006/10/30 18:20:05 mr_bones_ Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Worms and Scorched Earth-like game"
HOMEPAGE="http://atanks.sourceforge.net/"
SRC_URI="mirror://sourceforge/atanks/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/allegro"

S=${WORKDIR}/${PN}

src_unpack() {
	DATA_DIR="${GAMES_DATADIR}/${PN}"

	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}/${PV}-gentoo.patch" \
		"${FILESDIR}/${P}-gcc4.patch"

	sed -i \
		-e "s:DATA_DIR=.*:DATA_DIR=\\\\\"${DATA_DIR}\\\\\":" \
		src/Makefile \
		|| die "sed src/Makefile failed"
}

src_install() {
	dogamesbin atanks || die "dogamesbin failed"
	insinto "${DATA_DIR}"
	doins {credits,gloat,instr,revenge}.txt *dat || die "doins failed"
	dodoc BUGS Changelog Help.txt tanks.txt README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "NOTE: If you had atanks version 0.9.8b or less installed"
	einfo "remove ~/.atanks-config to take advantage of new features."
}
