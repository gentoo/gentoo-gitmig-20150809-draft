# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-alternatefire/quake3-alternatefire-2.0-r1.ebuild,v 1.3 2009/10/01 21:16:48 nyhm Exp $

MOD_DESC="adds unique new secondary attacks to weapons"
MOD_NAME="Alternate Fire"
MOD_DIR="alternatefire"

inherit games games-mods

SRC_URI="http://network3.filefront.com/planetquake3/alternatefire-${PV}.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/alternatefire/alternatefire-${PV}.zip"
HOMEPAGE="http://www.planetquake.com/alternatefire/"

LICENSE="freedist"

KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
