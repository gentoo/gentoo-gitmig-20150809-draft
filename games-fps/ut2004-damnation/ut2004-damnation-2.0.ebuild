# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-damnation/ut2004-damnation-2.0.ebuild,v 1.1 2006/12/13 20:58:30 wolf31o2 Exp $

MOD_DESC="steampunk fantasy/western action/adventure mod"
MOD_NAME="Damnation"
MOD_BINS="damnation"
MOD_TBZ2=${MOD_BINS}

inherit games games-mods

HOMEPAGE="http://www.damnationthegame.com/"
SRC_URI="mirror://liflg/damnation_${PV}-english.run"

LICENSE="freedist"

RDEPEND="${CATEGORY}/${GAME}"

KEYWORDS="-* ~amd64 ~x86"

src_install() {
	games-mods_src_install
	rm -f 3339_patch
}
