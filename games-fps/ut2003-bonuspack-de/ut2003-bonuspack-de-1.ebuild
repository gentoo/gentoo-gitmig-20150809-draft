# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2003-bonuspack-de/ut2003-bonuspack-de-1.ebuild,v 1.1 2004/04/09 22:12:49 wolf31o2 Exp $

inherit games

IUSE=""
DESCRIPTION="Digital Extremes Bonus Pack for UT2003"
HOMEPAGE="http://www.unrealtournament2003.com/"
SRC_URI="ftp://3dgamers.in-span.net/pub/3dgamers4/games/unrealtourn2/Missions/debonus.ut2mod.zip
	http://ftp1.gamesweb.com/kh1g6w2z/debonus.ut2mod.zip"

LICENSE="ut2003"
SLOT="1"
KEYWORDS="x86"
RESTRICT="nostrip nomirror"

DEPEND="app-arch/unzip"
RDEPEND="games-fps/ut2003"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/ut2003
Ddir=${D}/${dir}

src_unpack() {
	unzip ${DISTDIR}/${A} || die "unpacking"
}

src_install() {
	mkdir -p ${Ddir}/System ${Ddir}/Maps ${Ddir}/StaticMeshes ${Ddir}/Textures \
		${Ddir}/Music ${Ddir}/Help
	games_umod_unpack DEBonus.ut2mod
	prepgamesdirs
}
