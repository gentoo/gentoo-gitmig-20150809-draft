# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-cpma/quake3-cpma-1.38-r1.ebuild,v 1.1 2006/10/23 19:03:20 wolf31o2 Exp $

MOD_DESC="advanced FPS competition mod"
MOD_NAME="Challenge Pro Mode Arena"
#MOD_TBZ2
#MOD_ICON
MOD_DIR="cpma"

inherit games games-mods

HOMEPAGE="http://www.promode.org/"
SRC_URI="http://www.challenge-tv.com/demostorage/files/cpm/cpma${PV//.}-nomaps.zip
		 http://www.promode.org/files/cpma-mappack-full.zip"

LICENSE="as-is"

RDEPEND="games-fps/${GAME}"
