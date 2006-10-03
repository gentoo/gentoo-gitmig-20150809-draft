# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-truecombat/quake3-truecombat-1.2.ebuild,v 1.6 2006/10/03 16:46:55 wolf31o2 Exp $

MOD_DESC="Total transformation realism-based mod"
MOD_NAME=truecombat
MOD_BINS=tc

inherit games games-q3mod

SRC_WIRE="http://ftp.wireplay.com/pub/quake3arena/mods/truecombat/patches/win32"
SRC_TRIX="http://www.playtrix.net/download/truecombat"

HOMEPAGE="http://www.truecombat.com/"
SRC_URI="${SRC_WIRE}/TrueCombat1.0.zip
	http://downloads.gamecp.com/games/mods/TrueCombat1.0.zip
	${SRC_WIRE}/truecombat-1.0to1.0a.zip
	${SRC_TRIX}/TrueCombat-1.0aTo1.1.zip
	${SRC_WIRE}/tc12.zip
	${SRC_TRIX}/1.2/tc12.zip"

LICENSE="freedist"
RESTRICT="mirror"

src_unpack() {
	unpack TrueCombat1.0.zip
	unpack truecombat-1.0to1.0a.zip
	cd truecombat
	unpack TrueCombat-1.0aTo1.1.zip
	unpack tc12.zip
}
