MOD_DESC="total transformation realism based MOD"
MOD_NAME=truecombat
MOD_BINS=tc
inherit games games-q3mod

HOMEPAGE="http://www.truecombat.com/"
SRC_URI="http://mirror.inode.at/data/truecombat/TrueCombat1.0.zip
	http://www.diablo666.de/gamedome/truecombat-1.0to1.0a.zip
	http://www.playtrix.net/download/truecombat/TrueCombat-1.0aTo1.1.zip
	http://anton.aci.on.ca/tc/tc12.zip"

LICENSE="freedist"
RESTRICT="nomirror"

src_unpack() {
	unpack TrueCombat1.0.zip
	unpack truecombat-1.0to1.0a.zip
	cd truecombat
	unpack TrueCombat-1.0aTo1.1.zip
	unpack tc12.zip
}
