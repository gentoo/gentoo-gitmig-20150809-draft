# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-truecombat/quake3-truecombat-1.2.ebuild,v 1.5 2006/03/31 21:08:29 wolf31o2 Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME=truecombat
MOD_BINS=tc
inherit games games-q3mod

HOMEPAGE="http://www.truecombat.com/"
SRC_URI="http://mirror.inode.at/data/truecombat/TrueCombat1.0.zip
	http://ftp.wireplay.com/pub/quake3arena/mods/truecombat/patches/win32/truecombat-1.0to1.0a.zip
	http://www.playtrix.net/download/truecombat/TrueCombat-1.0aTo1.1.zip
	http://ftp.wireplay.co.uk/pub/quake3arena/mods/truecombat/patches/win32/tc12.zip"

LICENSE="freedist"
RESTRICT="mirror"

src_unpack() {
	unpack TrueCombat1.0.zip
	unpack truecombat-1.0to1.0a.zip
	cd truecombat
	unpack TrueCombat-1.0aTo1.1.zip
	unpack tc12.zip
}
