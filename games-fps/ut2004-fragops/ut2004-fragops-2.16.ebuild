# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-fragops/ut2004-fragops-2.16.ebuild,v 1.2 2006/04/20 15:44:28 wolf31o2 Exp $

MOD_DESC="Frag Ops is a realism mod"
MOD_NAME="Frag Ops"
MOD_BINS=fragops
MOD_TBZ2=frag.ops
MOD_ICON=${MOD_BINS}.png
inherit games games-ut2k4mod

HOMEPAGE="http://www.frag-ops.com/"
SRC_URI="${MOD_TBZ2}_${PV}-english.run"

LICENSE="freedist"
IUSE=""
