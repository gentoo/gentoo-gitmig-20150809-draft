# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/magiccube4d/magiccube4d-2.2.ebuild,v 1.3 2004/05/12 09:02:45 mr_bones_ Exp $

inherit games

MY_PV=${PV/./_}
DESCRIPTION="four-dimensional analog of Rubik's cube"
HOMEPAGE="http://www.superliminal.com/cube/cube.htm"
SRC_URI="http://www.superliminal.com/cube/mc4d-src-${MY_PV}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11"

S="${WORKDIR}/${PN}-src-${MY_PV}"

src_compile() {
	egamesconf || die
	emake DFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin magiccube4d || die "dogamesbin failed"
	dodoc ChangeLog MagicCube4D-unix.txt readme-unix.txt Intro.txt
	prepgamesdirs
}
