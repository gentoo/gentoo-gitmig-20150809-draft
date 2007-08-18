# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-urbanterror/quake3-urbanterror-4.0.ebuild,v 1.1 2007/08/18 00:46:11 wolf31o2 Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME="Urban Terror"
MOD_DIR="q3ut4"
MOD_BINS="ut4"

# Since this is easily done, we'll slot it so clans can easily play on older
# versions of the mod without having to mask anything.
SLOT=4

inherit games games-mods

HOMEPAGE="http://www.urbanterror.net/"
SRC_URI="
	http://games.mirrors.tds.net/pub/planetquake3/modifications/urbanterror/UrbanTerror40_full.zip
	http://unfoog.de/mirror/UrbanTerror40_full.zip
	ftp://mirrors.blueyonder.co.uk/mirrors/ftp.planetquake3.net/modifications/urbanterror/UrbanTerror40_full.zip
	http://www.ghozthosting.com/q3ut4/UrbanTerror40_full.zip
	http://hosting.map-depot.com/release/UrbanTerror40_full.zip
	http://outlands.quaddown.org/files/UrbanTerror40_full.zip
	http://dgames.vectranet.pl/UrbanTerror40_full.zip"

LICENSE="freedist"
SLOT="3"
RESTRICT="mirror strip"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"
