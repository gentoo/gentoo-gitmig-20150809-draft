# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-urbanterror/quake3-urbanterror-3.7-r1.ebuild,v 1.3 2007/01/29 16:35:11 wolf31o2 Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME="Urban Terror"
MOD_DIR="q3ut3"
MOD_BINS="ut3"

inherit games games-mods

HOMEPAGE="http://www.urbanterror.net/"
SRC_URI="ftp://ftp.edome.net/online/clientit/urbanterror3.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror31.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror32.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror33.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror34.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror35.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror36.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror37.zip
	http://q3.utca.hu/files/urbanterror3.zip
	http://q3.utca.hu/files/UrbanTerror31.zip
	http://q3.utca.hu/files/UrbanTerror32.zip
	http://q3.utca.hu/files/UrbanTerror33.zip
	http://q3.utca.hu/files/urbanterror/official/UrbanTerror34.zip
	http://q3.utca.hu/files/urbanterror/official/UrbanTerror35.zip
	http://q3.utca.hu/files/urbanterror/official/UrbanTerror36.zip
	http://q3.utca.hu/files/UrbanTerror37.zip
	http://urt.frisno.com/misc/urbanterror3.zip
	http://urt.frisno.com/misc/UrbanTerror31.zip
	http://urt.frisno.com/misc/UrbanTerror32.zip
	http://urt.frisno.com/misc/UrbanTerror33.zip
	http://www.backhed.se/UrbanTerror34.zip
	http://www.backhed.se/UrbanTerror35.zip
	http://www.backhed.se/UrbanTerror36.zip
	http://www.backhed.se/UrbanTerror37.zip
	http://www.clan-nua.com/~mods/Urban.Terror/UrbanTerror35.zip
	http://outlands.slofaca.net/files/UrbanTerror36.zip
	ftp://ftp.snt.utwente.nl/pub/games/urbanterror/patches/UrbanTerror36.zip
	http://outlands.quaddown.org/files/UrbanTerror37.zip
	http://outlands.slofaca.net/files/UrbanTerror37.zip"

LICENSE="freedist"
SLOT="3"
RESTRICT="mirror strip"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"

src_unpack() {
	unpack urbanterror3.zip
	cd q3ut3
	unpack UrbanTerror31.zip
	unpack UrbanTerror32.zip
	unpack UrbanTerror33.zip
	unpack UrbanTerror34.zip
	unpack UrbanTerror35.zip
	unpack UrbanTerror36.zip
	unpack UrbanTerror37.zip
}
