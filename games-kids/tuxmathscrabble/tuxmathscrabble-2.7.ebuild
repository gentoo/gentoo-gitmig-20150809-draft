# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-2.7.ebuild,v 1.1 2005/05/26 06:17:38 mr_bones_ Exp $

inherit distutils eutils games

DESCRIPTION="math-version of the popular board game for children 4-10"
HOMEPAGE="http://www.asymptopia.org/"
SRC_URI="mirror://sourceforge/tuxmathscrabble/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/python
	dev-python/pygame
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"

S=${WORKDIR}/TuxMathScrabble

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gentoo.patch
}

src_install() {
	DOCS="AUTHOR CHANGES VERSION"
	distutils_src_install
	newgamesbin tuxmathscrabble.py tuxmathscrabble
	prepgamesdirs
}
