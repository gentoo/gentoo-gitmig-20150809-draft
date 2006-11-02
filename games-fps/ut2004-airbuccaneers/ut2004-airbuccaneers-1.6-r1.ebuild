# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-airbuccaneers/ut2004-airbuccaneers-1.6-r1.ebuild,v 1.1 2006/11/02 19:59:53 wolf31o2 Exp $

MOD_DESC="pirate-style conversion with flying wooden ships"
MOD_NAME="Air Buccaneers"
MOD_BINS="airbuccaneers"
MOD_TBZ2="air.buccaneers"
MOD_ICON="air.buccaneers.xpm"

inherit games games-mods

HOMEPAGE="http://ludocraft.oulu.fi/airbuccaneers/"
SRC_URI="mirror://liflg/${MOD_TBZ2}_${PV}-english.run"

LICENSE="freedist"

KEYWORDS="~amd64 ~x86"

src_unpack() {
	games-mods_src_unpack
	# We don't want this file
	rm 3355_patch
}
