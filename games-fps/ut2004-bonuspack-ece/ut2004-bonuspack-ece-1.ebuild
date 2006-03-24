# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-ece/ut2004-bonuspack-ece-1.ebuild,v 1.5 2006/03/24 22:27:06 wolf31o2 Exp $

inherit games games-ut2k4mod

MY_P="ut2004-ecebonuspack.tar.bz2"
DESCRIPTION="Unreal Tournament 2004 - Editor's Choice Edition bonus pack"
HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI="mirror://3dgamers/unrealtourn2k4/Missions/${MY_P}"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="nostrip nomirror"
IUSE=""


RDEPEND="games-fps/ut2004-data"
DEPEND="${RDEPEND}"

S=${WORKDIR}/ut2004-ECEBonusPack

dir=${GAMES_PREFIX_OPT}/ut2004
Ddir=${D}/${dir}

pkg_setup() {
	check_dvd

	if [[ ! ${USE_ECE_DVD} -eq 1 ]]
	then
		games_pkg_setup
	fi
}

src_unpack() {
	if [[ ! ${USE_ECE_DVD} -eq 1 ]]
	then
		unpack ${A}
	fi
}

src_install() {
	if [[ ! ${USE_ECE_DVD} -eq 1 ]]
	then
		# Installing Editor's Choice Edition
		for n in {Animations,Help,Manual,Maps,Sounds,StaticMeshes,System,Textures}
		do
			dodir ${dir}/${n}
			cp -r ${S}/${n}/* ${Ddir}/${n} \
				|| die "copying ${n} from Editor's Choice Edition"
		done

		prepgamesdirs
	fi
}
