# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-strikeforce/ut2004-strikeforce-3.01-r1.ebuild,v 1.1 2006/12/12 15:18:45 wolf31o2 Exp $

MOD_DESC="a terrorist vs. strike force mod"
MOD_NAME="Strike Force"
MOD_BINS="strikeforce"
MOD_TBZ2="strike.force"
MOD_ICON="strike.force.xpm"

inherit games games-mods

HOMEPAGE="http://www.strikeforce2004.com/"
SRC_URI="mirror://liflg/strike.force_${PV}-english.run"

LICENSE="freedist"

KEYWORDS="~amd64 ~x86"

RDEPEND="${CATEGORY}/${GAME}"
