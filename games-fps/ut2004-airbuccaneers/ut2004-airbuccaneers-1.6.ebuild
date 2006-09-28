# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-airbuccaneers/ut2004-airbuccaneers-1.6.ebuild,v 1.2 2006/09/28 18:53:38 wolf31o2 Exp $

MOD_DESC="Air Buccaneers mod"
MOD_NAME="Air Buccaneers"
MOD_BINS=airbuccaneers
MOD_TBZ2=air.buccaneers
MOD_ICON=air.buccaneers.xpm
inherit games games-ut2k4mod

HOMEPAGE="http://ludocraft.oulu.fi/airbuccaneers/"
SRC_URI="mirror://liflg/${MOD_TBZ2}_${PV}-english.run"

LICENSE="freedist"
RESTRICT="mirror strip"
IUSE=""
