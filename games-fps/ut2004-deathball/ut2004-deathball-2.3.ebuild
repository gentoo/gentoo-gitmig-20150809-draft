# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-deathball/ut2004-deathball-2.3.ebuild,v 1.1 2005/04/25 13:04:21 wolf31o2 Exp $

MOD_DESC="Death Ball mod"
MOD_NAME="Death Ball"
MOD_BINS=deathb
MOD_TBZ2=death.ball
MOD_ICON=${MOD_BINS}.png
inherit games games-ut2k4mod

HOMEPAGE="http://www.deathball.net/"
SRC_URI="${MOD_TBZ2}_${PV}-english-2.run"

LICENSE="freedist"
IUSE=""
