# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/unreal-tournament-strikeforce/unreal-tournament-strikeforce-1.75.ebuild,v 1.3 2004/02/20 06:40:07 mr_bones_ Exp $

inherit games

MY_PV=${PV/./}
DESCRIPTION="A UT addon where you fight terrorists as part of an elite strikeforce"
HOMEPAGE="http://www.strikeforcecenter.com/"
SRC_URI="http://www.zvdk.nl/downloads/server/SF${MY_PV}.zip
	http://www.zvdk.nl/downloads/client/sf${MY_PV}_mappack1.zip
	http://www.zvdk.nl/downloads/client/sf${MY_PV}_mappack2.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND="|| ( games-fps/unreal-tournament games-fps/unreal-tournament-goty )"

S="${WORKDIR}"

src_unpack() {
	# we gotta do this cause there is a duplicate file across these zip's ...
	unpack SF${MY_PV}.zip
	unpack sf${MY_PV}_mappack1.zip
	rm -rf SF_Sounds/urbansnds.uax
	unpack sf${MY_PV}_mappack2.zip
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/unreal-tournament
	dodir ${dir}/Help
	mv *.txt ${D}/${dir}/Help/
	mv * ${D}/${dir}/
	prepgamesdirs
}
