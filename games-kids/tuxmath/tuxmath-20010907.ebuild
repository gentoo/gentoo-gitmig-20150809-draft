# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmath/tuxmath-20010907.ebuild,v 1.7 2004/11/22 11:28:29 josejx Exp $

inherit games

MY_P="${PN}-2001.09.07-0102"
DESCRIPTION="Educational arcade game where you have to solve math problems"
SRC_URI="mirror://sourceforge/tuxmath/${MY_P}.tar.gz"
HOMEPAGE="http://www.newbreedsoftware.com/tuxmath/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4"

S="${WORKDIR}/${PN}"

src_compile() {
	emake \
		DATA_PREFIX=${GAMES_DATADIR}/${PN} \
		BIN_PREFIX=${GAMES_BINDIR} \
		|| die "emake failed"
}

src_install() {
	find -name CVS -type d -exec rm -rf '{}' \;

	dogamesbin tuxmath || die "dogamesbin failed"

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r data/{images,sounds} "${D}/${GAMES_DATADIR}/${PN}/" \
		|| die "cp failed"

	dodoc docs/*.txt
	prepgamesdirs
}
