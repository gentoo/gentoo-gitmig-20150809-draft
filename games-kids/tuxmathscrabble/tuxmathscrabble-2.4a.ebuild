# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-2.4a.ebuild,v 1.2 2004/02/03 21:32:42 mr_bones_ Exp $

inherit distutils eutils games

MY_P=TuxMathScrabble_v${PV//./_}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="math-version of the popular board game for children 4-10"
HOMEPAGE="http://www.asymptopia.org/"
SRC_URI="mirror://sourceforge/tuxmathscrabble/${MY_P}.tgz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="dev-lang/python
	dev-python/pygame
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-fix-setup.patch
	sed -i \
		-e 's:/usr/local/bin/python:/usr/bin/python:' tuxmathscrabble.py \
			|| die "sed tuxmathscrabble.py failed"
}

src_install() {
	DOCS="AUTHOR CHANGES VERSION"
	distutils_src_install
	newgamesbin tuxmathscrabble.py tuxmathscrabble
	prepgamesdirs
}
