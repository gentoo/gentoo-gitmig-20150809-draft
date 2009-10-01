# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-threewave/quake3-threewave-1.7-r1.ebuild,v 1.2 2009/10/01 21:48:07 nyhm Exp $

MOD_NAME="Threewave CTF"
MOD_DIR="threewave"

inherit games games-mods

HOMEPAGE="http://www.threewave.com/"
SRC_URI="http://games.mirrors.tds.net/pub/planetquake3/modifications/threewavectf/threewave_16_full.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/threewavectf/threewave_17_update.zip"

LICENSE="freedist"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
