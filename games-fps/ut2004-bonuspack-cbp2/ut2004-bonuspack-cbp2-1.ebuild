# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-cbp2/ut2004-bonuspack-cbp2-1.ebuild,v 1.2 2006/09/28 18:55:26 wolf31o2 Exp $

MOD_DESC="Original Community Bonus Pack for UT2003 repacked for UT2004"
MOD_NAME=cbp2_volume1
MOD_TBZ2="cbp2_volume1 cbp2_volume2"

inherit games games-ut2k4mod

HOMEPAGE="http://www.planetunreal.com/cbp/"
SRC_URI="mirror://liflg/cbp2_volume1-multilanguage.run
	mirror://liflg/cbp2_volume2-multilanguage.run"

LICENSE="freedist"
RESTRICT="mirror strip"
IUSE=""
