# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/angrydd/angrydd-1.0.1.ebuild,v 1.2 2006/03/24 14:20:47 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Angry, Drunken Dwarves, a falling blocks game similar to Puzzle Fighter"
HOMEPAGE="http://www.sacredchao.net/~piman/angrydd/"
SRC_URI="http://www.sacredchao.net/~piman/angrydd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=dev-python/pygame-1.6.2
	>=dev-lang/python-2.3"

src_install() {
	make DESTDIR="${D}" PREFIX="${GAMES_DATADIR}" TO="${PN}" install \
		|| die "make install failed"
	rm -rf "${D}${GAMES_DATADIR}/games" "${D}${GAMES_DATADIR}/share"
	dodir "${GAMES_BINDIR}"
	dosym "${GAMES_DATADIR}/${PN}/angrydd.py" "${GAMES_BINDIR}/${PN}"
	doman angrydd.6
	dodoc README TODO HACKING
	make_desktop_entry angrydd "Angry, Drunken Dwarves"
	prepgamesdirs
}
