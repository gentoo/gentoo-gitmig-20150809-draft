# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-deathball/ut2004-deathball-2.3-r1.ebuild,v 1.4 2009/10/01 22:10:55 nyhm Exp $

MOD_DESC="Death Ball mod"
MOD_NAME="Death Ball"
MOD_BINS="deathb"
MOD_TBZ2="death.ball"
MOD_ICON="deathball.png"

inherit games games-mods

HOMEPAGE="http://www.deathball.net/"
SRC_URI="mirror://liflg/${MOD_TBZ2}_${PV}-english-2.run"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"
