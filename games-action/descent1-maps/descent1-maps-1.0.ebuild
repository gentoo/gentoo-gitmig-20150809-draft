# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent1-maps/descent1-maps-1.0.ebuild,v 1.3 2004/07/14 14:18:53 agriffis Exp $

inherit games

DESCRIPTION="Descent 1 third-party multiplayer maps"
HOMEPAGE="http://d1x.warpcore.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="games-action/d1x"


src_install () {

	local dir="${GAMES_DATADIR}/d1x"
	cd "${S}" || die

	# Install map data

	dodir "${dir}"

	insinto "${dir}"
	for x in *.rdl *.msn; do
		doins "${x}" || die
	done

	# Install documentation
	for x in *.txt; do
		dodoc "${x}" || die
	done

	prepgamesdirs
}
