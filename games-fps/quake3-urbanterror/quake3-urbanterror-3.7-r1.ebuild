# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-urbanterror/quake3-urbanterror-3.7-r1.ebuild,v 1.4 2007/08/17 23:46:29 wolf31o2 Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME="Urban Terror"
MOD_DIR="q3ut3"
MOD_BINS="ut3"

inherit games games-mods

HOMEPAGE="http://www.urbanterror.net/"
SRC_URI="
	http://games.mirrors.tds.net/pub/planetquake3/modifications/urbanterror/UrbanTerror31.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/urbanterror/UrbanTerror32.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/urbanterror/UrbanTerror33.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/urbanterror/UrbanTerror34.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/urbanterror/UrbanTerror35.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/urbanterror/UrbanTerror36.zip
	http://games.mirrors.tds.net/pub/planetquake3/modifications/urbanterror/UrbanTerror37.zip
	http://urt.frisno.com/misc/urbanterror3.zip
	http://urt.frisno.com/misc/UrbanTerror31.zip
	http://urt.frisno.com/misc/UrbanTerror32.zip
	http://urt.frisno.com/misc/UrbanTerror33.zip
	http://urt.frisno.com/misc/UrbanTerror34.zip
	http://urt.frisno.com/misc/UrbanTerror35.zip
	http://urt.frisno.com/misc/UrbanTerror36.zip
	http://urt.frisno.com/misc/UrbanTerror37.zip"

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
