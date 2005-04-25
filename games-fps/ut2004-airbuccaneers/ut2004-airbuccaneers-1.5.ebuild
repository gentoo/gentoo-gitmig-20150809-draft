# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-airbuccaneers/ut2004-airbuccaneers-1.5.ebuild,v 1.1 2005/04/25 13:02:40 wolf31o2 Exp $

MOD_DESC="Air Buccaneers mod"
MOD_NAME="Air Buccaneers"
MOD_BINS=airbuccaneers
MOD_TBZ2=air.buccaneers
MOD_ICON=AirBuccaneers.png
inherit games games-ut2k4mod

HOMEPAGE="http://ludocraft.oulu.fi/airbuccaneers/"
SRC_URI="${MOD_TBZ2}_${PV}-english.run"

LICENSE="freedist"
IUSE=""
