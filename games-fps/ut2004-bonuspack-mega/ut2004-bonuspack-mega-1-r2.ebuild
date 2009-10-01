# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-mega/ut2004-bonuspack-mega-1-r2.ebuild,v 1.3 2009/10/01 22:07:01 nyhm Exp $

MOD_DESC="Megapack bonus pack"
MOD_NAME="Megapack"

inherit games games-mods

MY_P="ut2004megapack-linux.tar.bz2"
MY_PN="Megapack"

HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI="mirror://3dgamers/unrealtourn2k4/Missions/${MY_P}
	http://0day.icculus.org/ut2004/${MY_P}
	ftp://ftp.games.skynet.be/pub/misc/${MY_P}
	http://sonic-lux.net/data/mirror/ut2004/${MY_P}"

LICENSE="ut2003"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

RDEPEND="games-fps/ut2004-data"

S=${WORKDIR}/UT2004MegaPack
dir=${GAMES_PREFIX_OPT}/ut2004
Ddir=${D}/${dir}

src_unpack() {
	games-mods_src_unpack
	cd "${S}"
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
	rm Textures/{AW-2k4XP,BenTex02,BenTropical01,BonusParticles,CicadaTex,Construction_S,HourAdaraTexor,jwfasterfiles,ONSBP_DestroyedVehicles,ONSBPTextures,PC_UrbanTex,UT2004ECEPlayerSkins}.utx
}

src_install() {
	# Backup files which a future bonuspack may try to overwrite
	for n in {Manifest.in{i,t},Packages.md5} ; do
		cp System/${n} System/${n}-${MY_PN}
	done

	# Install Megapack
	for n in {Help,Maps,Music,Sounds,StaticMeshes,System,Textures} ; do
		# doins is not used because of its unnecessary overhead
		dodir "${dir}"/${n}
		cp -r "${S}"/${n}/* "${Ddir}"/${n} \
			|| die "copying ${n} from ${MY_PN}"
	done

	prepgamesdirs
}
