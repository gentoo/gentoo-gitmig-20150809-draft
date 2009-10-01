# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-fragops/ut2004-fragops-2.16-r1.ebuild,v 1.3 2009/10/01 22:11:59 nyhm Exp $

MOD_DESC="realism mod"
MOD_NAME="Frag Ops"
MOD_BINS="fragops"
MOD_TBZ2="frag.ops"
MOD_ICON="${MOD_BINS}.png"

inherit games games-mods

HOMEPAGE="http://www.frag-ops.com/"
SRC_URI="mirror://liflg/${MOD_TBZ2}_${PV}-english.run"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"
