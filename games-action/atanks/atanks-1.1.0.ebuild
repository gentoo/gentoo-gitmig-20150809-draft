# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/atanks/atanks-1.1.0.ebuild,v 1.2 2004/03/24 04:39:53 mr_bones_ Exp $

inherit games

DATA_DIR="${GAMES_DATADIR}/${PN}"
S="${WORKDIR}/${PN}"
DESCRIPTION="Worms and Scorched Earth-like game"
HOMEPAGE="http://atanks.sourceforge.net/"
SRC_URI="mirror://sourceforge/atanks/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

RDEPEND="virtual/x11
	>=media-libs/allegro-4.0.3
	>=media-libs/allegttf-2.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:DATA_DIR=.*:DATA_DIR=\\\\\"${DATA_DIR}\\\\\":" src/Makefile || \
			die "sed src/Makefile failed"
}

src_install() {
	dogamesbin atanks || die "dogamesbin failed"
	dodir "${DATA_DIR}"
	cp {credits,gloat,instr,revenge}.txt *dat "${D}${DATA_DIR}" || \
		die "cp failed"
	dodoc BUGS Changelog Help.txt tanks.txt README TODO || die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	einfo "NOTE: If you had atanks version 0.9.8b or less installed"
	einfo "remove ~/.atanks-config to take advantage of new features."
	games_pkg_postinst
}
