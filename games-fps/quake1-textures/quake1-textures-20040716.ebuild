# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1-textures/quake1-textures-20040716.ebuild,v 1.6 2008/02/14 23:18:15 nyhm Exp $

inherit games

DESCRIPTION="a collection of new and high resolution textures for id's Quake"
HOMEPAGE="http://np.teamfortress.org/"
SRC_URI="http://np.teamfortress.org/iM/textures/textures-406files-7-16-04.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_install () {
	dodoc *.txt
	rm *.txt
	insinto "${GAMES_DATADIR}"/quake1/id1/textures
	doins * || die "doins failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Use a client like quakeforge (nq-glx) to take advantage of these"
}
