# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-etpro/enemy-territory-etpro-3.2.6-r1.ebuild,v 1.1 2006/10/23 18:37:10 wolf31o2 Exp $

MOD_DESC="a series of minor additions to Enemy Territory to make it more fun"
MOD_NAME="ETPro"
#MOD_TBZ2
#MOD_ICON
MOD_DIR="etpro"
GAME="enemy-territory"

inherit games games-mods

HOMEPAGE="http://bani.anime.net/etpro/"
SRC_URI="http://etpro.anime.net/etpro-${PV//./_}.zip"

LICENSE="as-is"

KEYWORDS="-* ~amd64 ~x86"

RDEPEND="games-fps/${GAME}"
