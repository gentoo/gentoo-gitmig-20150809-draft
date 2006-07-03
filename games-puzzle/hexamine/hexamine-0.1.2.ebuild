# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/hexamine/hexamine-0.1.2.ebuild,v 1.1 2006/07/03 23:50:49 mr_bones_ Exp $

inherit games

DESCRIPTION="Hexagonal Minesweeper"
HOMEPAGE="http://grayswander.tripod.com/hexamine/"
SRC_URI="http://grayswander.tripod.com/hexamine/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="media-libs/libsdl
	dev-python/pygame"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Modify game data directory
	sed -i \
		-e "s:\`dirname \$0\`:${GAMES_DATADIR}/${PN}:" \
		-e "s:\./hexamine:exec python &:" \
		hexamine || die "sed failed"
}

src_install() {
	dogamesbin hexamine || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins *.py *.png *.ttf || die "doins failed"
	dodoc ABOUT README
	prepgamesdirs
}
