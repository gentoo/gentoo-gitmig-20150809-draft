# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-excessiveplus/quake3-excessiveplus-1.03.ebuild,v 1.1 2006/10/26 14:14:34 wolf31o2 Exp $

MOD_DESC="modification making the weapons much faster and stronger"
MOD_NAME="Excessive Plus"
MOD_DIR="excessiveplus"
MOD_ICON="excessiveplus.ico"

inherit games games-mods

HOMEPAGE="http://www.excessiveplus.net/"
SRC_URI="http://www.excessiveplus.net/downloads/xp-${PV}-full.zip"

LICENSE="as-is"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"
