# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-deathball/ut2004-deathball-2.3-r1.ebuild,v 1.3 2007/01/10 19:55:51 wolf31o2 Exp $

MOD_DESC="Death Ball mod"
MOD_NAME="Death Ball"
MOD_BINS="deathb"
MOD_TBZ2="death.ball"
MOD_ICON="deathball.png"

inherit games games-mods

HOMEPAGE="http://www.deathball.net/"
SRC_URI="mirror://liflg/${MOD_TBZ2}_${PV}-english-2.run"

LICENSE="freedist"

RDEPEND="${CATEGORY}/${GAME}"
