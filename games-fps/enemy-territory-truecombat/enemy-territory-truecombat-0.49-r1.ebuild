# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-truecombat/enemy-territory-truecombat-0.49-r1.ebuild,v 1.1 2006/10/23 18:49:59 wolf31o2 Exp $

MOD_DESC="a team-based realism modification"
MOD_NAME="True Combat"
#MOD_TBZ2
MOD_ICON="tce_icon_pc.ico"
MOD_DIR="tcetest"
GAME="enemy-territory"

inherit games games-mods

HOMEPAGE="http://truecombat.com/"
SRC_URI="http://pumpkin.game-server.cc/files/tcetest049.zip"

LICENSE="as-is"

KEYWORDS="-* ~amd64 ~x86"

RDEPEND="games-fps/${GAME}"
