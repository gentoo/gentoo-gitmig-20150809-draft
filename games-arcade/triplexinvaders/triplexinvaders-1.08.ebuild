# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/triplexinvaders/triplexinvaders-1.08.ebuild,v 1.1 2007/04/14 11:12:04 tupone Exp $

inherit games

DESCRIPTION="An Alien Invaders style game with 3d graphics"
HOMEPAGE="http://triplexinvaders.infogami.com"
SRC_URI="http://acm.jhu.edu/~arthur/invaders/${P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE="psyco"

DEPEND="app-arch/unzip
	dev-python/pygame
	dev-python/pyopengl
	psyco? ( dev-python/psyco )"

src_install() {
	insinto "${GAMES_LIBDIR}/${PN}"
	doins -r *.py models sound options.conf hiscores || die "doins failed"
	games_make_wrapper ${PN} "python ./invaders.py" "${GAMES_LIBDIR}/${PN}"
	dodoc README.txt TODO.txt || die "Installing doc failed"

	prepgamesdirs
}
