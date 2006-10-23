# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-alternatefire/quake3-alternatefire-2.0-r1.ebuild,v 1.1 2006/10/23 20:05:08 wolf31o2 Exp $

MOD_DESC="adds unique new secondary attacks to weapons"
MOD_NAME="Alternate Fire"
MOD_DIR="alternatefire"

inherit games games-mods

SRC_URI="http://network3.filefront.com/planetquake3/alternatefire-${PV}.zip"
HOMEPAGE="http://www.planetquake.com/alternatefire/"

LICENSE="freedist"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"
