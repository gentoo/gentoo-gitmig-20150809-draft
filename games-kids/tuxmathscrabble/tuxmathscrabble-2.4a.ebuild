# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-2.4a.ebuild,v 1.1 2003/11/08 06:59:19 vapier Exp $

inherit games distutils

MY_P=TuxMathScrabble_v${PV//./_}
DESCRIPTION="math-version of the popular board game for children 4-10"
HOMEPAGE="http://www.asymptopia.org/"
SRC_URI="mirror://sourceforge/tuxmathscrabble/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=""
RDEPEND="dev-lang/python
	dev-python/pygame
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-fix-setup.patch
	sed -i 's:/usr/local/bin/python:/usr/bin/python:' tuxmathscrabble.py
}

src_install() {
	DOCS="AUTHOR CHANGES VERSION"
	distutils_src_install
	newgamesbin tuxmathscrabble.py tuxmathscrabble
	prepgamesdirs
}
