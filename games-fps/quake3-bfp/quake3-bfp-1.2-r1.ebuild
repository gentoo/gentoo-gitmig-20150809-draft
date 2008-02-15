# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-bfp/quake3-bfp-1.2-r1.ebuild,v 1.3 2008/02/15 01:00:12 wolf31o2 Exp $

MOD_DESC="take control of Ki-powered superheros and battle in a mostly aerial fight"
MOD_NAME="Bid For Power"
MOD_DIR="bfpq3"
MOD_BINS="bfp"

inherit games games-mods

HOMEPAGE="http://www.planetquake.com/bidforpower/"
SRC_URI="http://games.mirrors.tds.net/pub/planetquake3/modifications/bidforpower/bidforpower${PV/./-}.zip"

LICENSE="freedist"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"
