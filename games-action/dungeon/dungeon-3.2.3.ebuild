# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/dungeon/dungeon-3.2.3.ebuild,v 1.2 2004/02/20 06:13:56 mr_bones_ Exp $

inherit games

DESCRIPTION="A linux port of the Dungeon game once distributed by DECUS"
HOMEPAGE="http://www.ibiblio.org/linsearch/lsms/dungeon-3.2.3.html"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/games/textrpg/${P}.src.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="dev-lang/f2c
	>=sys-apps/sed-4"

S="${WORKDIR}/dungn32c"

DATS="${GAMES_DATADIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O:${CFLAGS}:g" Makefile || die "sed Makefile failed"
}

src_compile() {
	make game.c || die "make game.c failed"
	sed -i \
		-re "s:d(indx|text).dat:${DATS}/&:g" \
		-e "s:ofnmlen = [^;]+:&+${#DATS}+1:g" \
		game.c || die "sed game.c failed"

	emake || die
}

src_install() {
	dogamesbin dungeon
	insinto ${DATS}
	doins dindx.dat dtext.dat
	doman ${FILESDIR}/dungeon.6
	dodoc README *.txt *.doc
	prepgamesdirs
}
