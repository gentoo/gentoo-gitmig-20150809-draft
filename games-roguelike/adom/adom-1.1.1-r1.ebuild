# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/adom/adom-1.1.1-r1.ebuild,v 1.2 2004/02/20 06:55:42 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Ancient Domains Of Mystery rogue-like game"
HOMEPAGE="http://www.adom.de/"
SRC_URI="http://www.adom.de/adom/download/linux/${P//.}-elf.tar.gz"

LICENSE="adom"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.0"

S=${WORKDIR}/${PN}

src_install() {
	exeinto ${GAMES_PREFIX_OPT}/bin
	doexe adom

	dodir ${GAMES_STATEDIR}/${PN}
	keepdir ${GAMES_STATEDIR}/${PN}
	echo ${GAMES_STATEDIR}/${PN} > adom_ds.cfg
	insinto /etc
	doins adom_ds.cfg

	edos2unix adomfaq.txt
	dodoc adomfaq.txt manual.doc readme.1st

	prepgamesdirs
	fperms g+w ${GAMES_STATEDIR}/${PN}
}
