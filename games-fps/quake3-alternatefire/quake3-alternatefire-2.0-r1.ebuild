# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-alternatefire/quake3-alternatefire-2.0-r1.ebuild,v 1.4 2009/10/06 22:19:05 nyhm Exp $

EAPI=2

MOD_DESC="adds unique new secondary attacks to weapons"
MOD_NAME="Alternate Fire"
MOD_DIR="alternatefire"

inherit games games-mods

HOMEPAGE="http://www.planetquake.com/alternatefire/"
SRC_URI="http://network3.filefront.com/planetquake3/alternatefire-${PV}.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/alternatefire/alternatefire-${PV}.zip"

LICENSE="freedist"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
