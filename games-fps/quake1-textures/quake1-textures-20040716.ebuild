# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1-textures/quake1-textures-20040716.ebuild,v 1.2 2004/08/30 23:29:27 dholm Exp $

inherit games

DESCRIPTION="a collection of new and high resolution textures for id's Quake"
HOMEPAGE="http://www.quake.cz/winclan/qe1/"
SRC_URI="http://np.teamfortress.org/im/textures/textures-406files-7-16-04.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="app-arch/unzip"

S=${WORKDIR}

src_install () {
	dodoc *.txt
	rm *.txt
	insinto ${GAMES_DATADIR}/quake-data/id1/textures
	doins * || die "doins failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Use a client like quakeforge (nq-glx) to take advantage of these"
}
