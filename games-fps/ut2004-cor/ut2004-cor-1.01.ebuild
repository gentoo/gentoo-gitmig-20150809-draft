# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-cor/ut2004-cor-1.01.ebuild,v 1.2 2009/10/01 22:20:58 nyhm Exp $

MOD_DESC="Shape-shifting robot teamplay mod"
MOD_NAME="Counter Organic Revolution"
MOD_BINS="cor"
MOD_TBZ2="cor_beta${PV}-english"
MOD_ICON="cor.xpm"

inherit games games-mods

HOMEPAGE="http://www.corproject.com/"
SRC_URI="mirror://liflg/cor_beta${PV}-english.run"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"
