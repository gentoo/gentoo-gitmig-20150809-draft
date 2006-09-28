# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-domain2049/ut2004-domain2049-2.2.ebuild,v 1.4 2006/09/28 18:58:32 wolf31o2 Exp $

MOD_DESC="Domain2049 is a futuristic semi-realism mod"
MOD_NAME="Domain2049"
MOD_BINS=domain2049
MOD_TBZ2=${MOD_BINS}
MOD_ICON=${MOD_BINS}.png
inherit games games-ut2k4mod

HOMEPAGE="http://www.domain2049.com/"
SRC_URI="mirror://liflg/${MOD_TBZ2}_${PV}-english.run"

LICENSE="freedist"
RESTRICT="mirror strip"
IUSE=""
