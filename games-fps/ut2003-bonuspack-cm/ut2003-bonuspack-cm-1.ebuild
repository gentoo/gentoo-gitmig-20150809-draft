# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2003-bonuspack-cm/ut2003-bonuspack-cm-1.ebuild,v 1.1 2004/04/09 22:14:21 wolf31o2 Exp $

inherit games

IUSE=""
DESCRIPTION="Community Bonus Pack for UT2003"
HOMEPAGE="http://www.unrealtournament2003.com/"
SRC_URI="ftp://dl3.edgefiles.com/games-fusion.net/www/patches/ut2003/cbp2003.zip
	ftp://ftp.multiplay.co.uk/pub/games/fps/unrealtournament2003/mappacks/cbp2003.zip
	http://ftp1.gamesweb.com/cq2ert6g/cbp2003.zip"

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
		${Ddir}/Music ${Ddir}/Help ${Ddir}/Animations
	games_umod_unpack CBP2003.ut2mod
	rm ${Ddir}/Readme.txt "${Ddir}/cbp installer logo1.bmp"
	prepgamesdirs
}
