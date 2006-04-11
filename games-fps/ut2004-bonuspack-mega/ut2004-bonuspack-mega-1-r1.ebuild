# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-mega/ut2004-bonuspack-mega-1-r1.ebuild,v 1.4 2006/04/11 11:48:44 wolf31o2 Exp $

inherit games games-ut2k4mod

MY_P="ut2004megapack-linux.tar.bz2"
MY_PN="Megapack"

DESCRIPTION="Unreal Tournament 2004 - Mega bonus pack"
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
# File comparison was made with ut2004-3369-r2
# Need ut2004-3369-r4, to take ownership of {Manifest.in{i,t},Packages.md5}
RDEPEND=">=games-fps/ut2004-3369-r4
	>=games-fps/ut2004-data-3186-r2
	>=games-fps/ut2004-bonuspack-ece-1-r1"
DEPEND="${RDEPEND}"

S=${WORKDIR}/UT2004MegaPack
dir=${GAMES_PREFIX_OPT}/ut2004
Ddir=${D}/${dir}

src_unpack() {
	# Override games-ut2k4mod
	unpack ${A}
}

src_install() {
	# Remove files in Megapack which are already installed
	rm -r Animations Speech Web

	rm Help/{ReadMePatch.int.txt,UT2004Logo.bmp}
	mv Help/BonusPackReadme.txt Help/${MY_PN}Readme.txt

	rm Maps/ONS-{Adara,IslandHop,Tricky,Urban}.ut2
	rm Sounds/{CicadaSnds,DistantBooms,ONSBPSounds}.uax
	rm StaticMeshes/{BenMesh02,BenTropicalSM01,HourAdara,ONS-BPJW1,PC_UrbanStatic}.usx

	# System
	rm System/{AL,AS-,B,b,C,D,E,F,G,I,L,O,o,S,s,U,V,W,X,x}*
	rm System/{ucc,ut2004}-bin
	rm System/{ucc,ut2004}-bin-linux-amd64

	# Backup files which a future bonuspack may try to overwrite
	for n in {Manifest.in{i,t},Packages.md5} ; do
		cp System/${n} System/${n}-${MY_PN}
	done

	rm Textures/{AW-2k4XP,BenTex02,BenTropical01,BonusParticles,CicadaTex,Construction_S,HourAdaraTexor,jwfasterfiles,ONSBP_DestroyedVehicles,ONSBPTextures,PC_UrbanTex,UT2004ECEPlayerSkins}.utx

	# Install Megapack
	for n in {Help,Maps,Music,Sounds,StaticMeshes,System,Textures} ; do
		# doins is not used because of its unnecessary overhead
		dodir "${dir}"/${n}
		cp -r "${S}"/${n}/* "${Ddir}"/${n} \
			|| die "copying ${n} from ${MY_PN}"
	done

	prepgamesdirs
}
