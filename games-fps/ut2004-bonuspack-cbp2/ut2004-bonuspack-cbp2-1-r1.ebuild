# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-cbp2/ut2004-bonuspack-cbp2-1-r1.ebuild,v 1.1 2006/11/07 16:56:19 wolf31o2 Exp $

MOD_DESC="original Community Bonus Pack for UT2003 repacked for UT2004"
MOD_NAME="cbp2_volume1"
MOD_TBZ2="cbp2_volume1 cbp2_volume2"

inherit games games-mods

HOMEPAGE="http://www.planetunreal.com/cbp/"
SRC_URI="mirror://liflg/cbp2_volume1-multilanguage.run
	mirror://liflg/cbp2_volume2-multilanguage.run"

LICENSE="freedist"

KEYWORDS="~amd64 ~x86"

RDEPEND="games-fps/ut2004"
