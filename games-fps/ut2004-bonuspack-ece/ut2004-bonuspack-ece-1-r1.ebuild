# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-ece/ut2004-bonuspack-ece-1-r1.ebuild,v 1.4 2006/04/11 11:47:46 wolf31o2 Exp $

inherit games games-ut2k4mod

MY_P="ut2004megapack-linux.tar.bz2"

DESCRIPTION="Unreal Tournament 2004 - Editor's Choice Edition bonus pack"
HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI="mirror://3dgamers/unrealtourn2k4/Missions/${MY_P}
	http://0day.icculus.org/ut2004/${MY_P}
	ftp://ftp.games.skynet.be/pub/misc/${MY_P}
	http://sonic-lux.net/data/mirror/ut2004/${MY_P}"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror strip"
IUSE=""

# Override games-ut2k4mod eclass
RDEPEND=">=games-fps/ut2004-3369-r1
	games-fps/ut2004-data"
DEPEND="${RDEPEND}"

S=${WORKDIR}/UT2004MegaPack
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
		# Remove megapack files which are not in ece
		rm Animations/ONSNewTank-A.ukx
		rm Help/ReadMePatch.int.txt
		# Help/{DebuggerLogo.bmp,InstallerLogo.bmp,Unreal.ico,UnrealEd.ico}
		# are not in megapack.
		# Keep new Help/UT2004Logo.bmp
		# Manual dir does not exist in megapack
		rm Maps/{AS*,CTF*,DM*}
		rm Sounds/A_Announcer_BP2.uax
		rm StaticMeshes/{JumpShipObjects.usx,Ty_RocketSMeshes.usx}
		rm System/{A*,b*,B*,CacheRecords.ucl,*.det,*.est,*.frt,*.itt,*.kot}
		rm System/{CTF*,D*,Editor*,G*,I*,L*,ONS-Arc*,Onslaught.*,*.md5}
		rm System/{u*,U*,V*,X*,Core.u,Engine.u,F*,*.ucl,Sk*}
		rm Textures/{J*,j*,T*}
		rm -r Web

		# The file lists of ut2004-3369-r1 and -r2 are identical
		# Remove files owned by ut2004-3369-r2
		rm Help/UT2004Logo.bmp
		# The 2 Manifest files have not changed
		rm System/{Manifest.in{i,t},OnslaughtFull.int}
		rm System/{Core.int,Engine.int,Setup.int,Window.int}
		rm System/{OnslaughtFull.u,OnslaughtBP.u}

		# Install Editor's Choice Edition
		for n in {Animations,Help,Maps,Sounds,StaticMeshes,System,Textures}
		do
			dodir "${dir}"/${n}
			cp -r "${S}"/${n}/* "${Ddir}"/${n} \
				|| die "copying ${n} from Editor's Choice Edition"
		done

		prepgamesdirs
	fi
}
