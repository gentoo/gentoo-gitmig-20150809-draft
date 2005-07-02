# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/qct/qct-0.7.ebuild,v 1.6 2005/07/02 21:16:20 vapier Exp $

inherit games eutils

DESCRIPTION="Quiet Console Town puts you in the place of the mayor of a budding new console RPG city"
HOMEPAGE="http://sourceforge.net/projects/qct/"
SRC_URI="mirror://sourceforge/qct/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.2.1
	>=dev-python/pygame-1.5.5"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-constant.patch
}

src_install() {
	local destdir="${GAMES_DATADIR}/${PN}"
	insinto "${destdir}"
	exeinto "${destdir}"

	dodoc README
	doins *.py *.png
	doexe qct.py

	games_make_wrapper qct "./qct.py" "${destdir}"

	prepgamesdirs
}
