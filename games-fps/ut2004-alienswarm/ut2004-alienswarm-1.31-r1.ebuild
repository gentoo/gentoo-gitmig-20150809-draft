# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-alienswarm/ut2004-alienswarm-1.31-r1.ebuild,v 1.1 2006/10/23 19:27:13 wolf31o2 Exp $

AS_V="1.3"

MOD_DESC="an overhead view tactical squad-based shooter"
MOD_NAME="Alien Swarm"
MOD_BINS="alienswarm alienswarm-load-phalanx.campaign alienswarm-load-telic.campaign alienswarm-new-phalanx.campaign alienswarm-new-telic.campaign"
MOD_TBZ2="alienswarm_${AS_V} alien.swarm_phalanx.campaign alien.swarm_telic.campaign"
MOD_ICON="alienswarm.xpm"

MY_PV=${PV/./}
MY_MOD=${MOD_NAME/ /}

inherit games games-mods

HOMEPAGE="http://www.blackcatgames.com/swarm/"
SRC_URI="mirror://liflg/alien.swarm_${AS_V}-english.run
	mirror://liflg/alien.swarm_phalanx.campaign-addon.run
	mirror://liflg/alien.swarm_telic.campaign-addon.run
	http://www.night-blade.com/AS/${MY_MOD}_${AS_V/./}_to_${MY_PV}_Patch.zip"

IUSE=""

RDEPEND="${CATEGORY}/${GAME}"

KEYWORDS="-* ~amd64 ~x86"

src_install() {
	games-mods_src_install
	cp -pPR "${S}"/${MY_MOD} ${Ddir} || die
	prepgamesdirs
}
