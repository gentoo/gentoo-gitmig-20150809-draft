# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-truecombat/enemy-territory-truecombat-0.49b.ebuild,v 1.1 2007/01/30 22:36:46 wolf31o2 Exp $

MOD_DESC="a team-based realism modification"
MOD_NAME="True Combat"
MOD_ICON="tce_icon_pc.ico"
MOD_DIR="tcetest"
GAME="enemy-territory"

inherit games games-mods

HOMEPAGE="http://truecombat.com/"
SRC_URI="http://pumpkin.game-server.cc/files/tcetest049.zip
		http://pumpkin.game-server.cc/files/tc049b_all_os_fixed.zip"

LICENSE="as-is"

KEYWORDS="-* ~amd64 ~x86"

RDEPEND="games-fps/${GAME}"

src_unpack() {
		games-mods_src_unpack
		mv *.{so,dat,pk3,dll} ${MOD_DIR} || die
}
