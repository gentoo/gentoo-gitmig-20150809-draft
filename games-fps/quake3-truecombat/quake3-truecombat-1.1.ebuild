# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-truecombat/quake3-truecombat-1.1.ebuild,v 1.2 2004/02/20 06:40:07 mr_bones_ Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME=truecombat
MOD_BINS=tc
inherit games games-q3mod

HOMEPAGE="http://www.truecombat.com/"
SRC_URI="http://mirror.inode.at/data/truecombat/TrueCombat1.0.zip
	http://www.diablo666.de/gamedome/truecombat-1.0to1.0a.zip
	http://www.playtrix.net/download/truecombat/TrueCombat-1.0aTo1.1.zip"

LICENSE="freedist"

src_unpack() {
	unpack TrueCombat1.0.zip
	unpack truecombat-1.0to1.0a.zip
	cd truecombat
	unpack TrueCombat-1.0aTo1.1.zip
}
