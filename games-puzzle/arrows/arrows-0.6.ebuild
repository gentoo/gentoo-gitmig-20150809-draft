# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/arrows/arrows-0.6.ebuild,v 1.1 2004/06/05 06:04:20 mr_bones_ Exp $

inherit games

DESCRIPTION="Guide the spinning blue thing through the maze of arrows, creating and destroying arrows as necessary to collect the green things"
HOMEPAGE="http://noreason.ca/?file=software"
SRC_URI="http://noreason.ca/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Modify path to data
	sed -i \
		-e "s:arrfl:${GAMES_DATADIR}/${PN}/arrfl:" \
		-e 's:nm\[9:nm[35:' \
		-e 's:nm\[6:nm[30:' \
		-e 's:nm\[7:nm[31:' \
		game.c || die "sed game.c failed"
}

src_compile() {
	emake CCOPTS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin arrows || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins arrfl* || die "doins failed"
	dodoc README
	prepgamesdirs
}
