# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmath/tuxmath-20010907.ebuild,v 1.2 2004/02/20 06:42:26 mr_bones_ Exp $

inherit games

MY_P="${PN}-2001.09.07-0102"
DESCRIPTION="Educational arcade game where you have to solve math problems"
SRC_URI="mirror://sourceforge/tuxmath/${MY_P}.tar.gz"
HOMEPAGE="http://www.newbreedsoftware.com/tuxmath/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4"

S=${WORKDIR}/${PN}

src_compile() {
	emake \
		DATA_PREFIX=${GAMES_DATADIR}/${PN} \
		BIN_PREFIX=${GAMES_BINDIR} \
		|| die
}

src_install() {
	find -name CVS -type d -exec rm -rf '{}' \;

	dogamesbin tuxmath

	dodir ${GAMES_DATADIR}/${PN}
	mv data/{images,sounds} ${D}/${GAMES_DATADIR}/${PN}/

	dodoc docs/*.txt
	prepgamesdirs
}
