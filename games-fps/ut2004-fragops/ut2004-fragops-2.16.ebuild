# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-fragops/ut2004-fragops-2.16.ebuild,v 1.1 2005/04/25 19:31:42 wolf31o2 Exp $

MOD_DESC="Frag Ops is a realisim mod"
MOD_NAME="Frag Ops"
MOD_BINS=fragops
MOD_TBZ2=frag.ops
MOD_ICON=${MOD_BINS}.png
inherit games games-ut2k4mod

HOMEPAGE="http://www.frag-ops.com/"
SRC_URI="${MOD_TBZ2}_${PV}-english.run"

LICENSE="freedist"
IUSE=""
