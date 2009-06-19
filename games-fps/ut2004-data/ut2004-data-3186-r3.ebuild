# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-data/ut2004-data-3186-r3.ebuild,v 1.13 2009/06/19 12:42:39 nyhm Exp $

inherit eutils games games-ut2k4mod

DESCRIPTION="Unreal Tournament 2004 - This is the data portion of UT2004"
HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI=""

LICENSE="ut2003"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="strip"
IUSE=""
QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/ut2004/System/libSDL-1.2.so.0"

DEPEND="games-util/uz2unpack"
PDEPEND="games-fps/ut2004"

S=${WORKDIR}

GAMES_LICENSE_CHECK="yes"
dir=${GAMES_PREFIX_OPT}/ut2004
Ddir=${D}/${dir}

grabdirs() {
	local d srcdir

	for d in {Music,Sounds,Speech,StaticMeshes,Textures} ; do
		srcdir=${CDROM_ROOT}/$1${d}
		# Is flexible to handle CD_ROOT vs CD_ROOT_1 mixups
		[[ -d "${srcdir}" ]] || srcdir=${CDROM_ROOT}/${d}
		if [[ -d "${srcdir}" ]] ; then
			insinto "${dir}"
			doins -r "${srcdir}" || die "doins ${srcdir} failed"
		fi
	done
}

pkg_setup() {
	games_pkg_setup
	ewarn "This is a huge package.  If you do not have at least 7GB of free"
	ewarn "disk space in ${PORTAGE_TMPDIR} and also in ${GAMES_PREFIX_OPT} then"
	ewarn "you should abort this installation now and free up some space."
}

src_unpack() {
	check_dvd

	if [[ "${USE_DVD}" -eq 1 ]]
	then
		DISK1="CD1/"
		DISK2="CD2/"
		DISK3="CD3/"
		DISK4="CD4/"
		DISK5="CD5/"
		DISK6="CD6/"
		if [[ "${USE_ECE_DVD}" -eq 1 ]]
		then
			cdrom_get_cds "${DISK1}"System/UT2004.ini \
				"${DISK2}"Textures/2K4Fonts.utx.uz2 \
				"${DISK3}"Textures/ONSDeadVehicles-TX.utx.uz2 \
				"${DISK4}"Textures/XGameShaders2004.utx.uz2 \
				"${DISK5}"Speech/ons.xml \
				"${DISK6}"/Sounds/TauntPack.det_uax.uz2
		else
			cdrom_get_cds "${DISK1}"/System/UT2004.ini \
				"${DISK2}"/Textures/2K4Fonts.utx.uz2 \
				"${DISK3}"/Textures/ONSDeadVehicles-TX.utx.uz2 \
				"${DISK4}"/StaticMeshes/AlienTech.usx.uz2 \
				"${DISK5}"/Speech/ons.xml \
				"${DISK6}"/Sounds/TauntPack.det_uax.uz2
		fi
	else
		cdrom_get_cds System/UT2004.ini \
			Textures/2K4Fonts.utx.uz2 \
			Textures/ONSDeadVehicles-TX.utx.uz2 \
			StaticMeshes/AlienTech.usx.uz2 \
			Speech/ons.xml \
			Sounds/TauntPack.det_uax.uz2
	fi
	unpack_makeself "${CDROM_ROOT}"/linux-installer.sh \
		|| die "unpacking linux installer"
	use x86 && unpack ./linux-x86.tar
	use amd64 && unpack ./linux-amd64.tar
}

src_install() {
	local diskno srcdir varname j

	# Disk 1
	einfo "Copying files from Disk 1..."
	insinto "${dir}"
	doins -r "${CDROM_ROOT}/${DISK1}"{Animations,ForceFeedback,Help,KarmaData,Maps,Sounds,Web} \
		|| die "copying directories"
	insinto "${dir}"/System
	doins -r "${CDROM_ROOT}/${DISK1}"System/{editorres,*.{bat,bmp,dat,det,est,frt,ini,int,itt,kot,md5,smt,tmt,u,ucl,upl,url}} \
		|| die "copying System files"
	insinto "${dir}"/Manual
	doins "${CDROM_ROOT}/${DISK1}"Manual/Manual.pdf \
		|| die "copying manual"
	insinto "${dir}"/Benchmark/Stuff
	doins -r "${CDROM_ROOT}/${DISK1}"Benchmark/Stuff/* \
		|| die "copying Benchmark files"
	cdrom_load_next_cd

	for diskno in {2..5} ; do
		einfo "Copying files from Disk ${diskno}..."
		varname="DISK${diskno}"
		srcdir=${!varname}
		grabdirs "${srcdir}"
		cdrom_load_next_cd
	done

	# Disk 6
	einfo "Copying files from Disk 6..."
	grabdirs "${DISK6}"

	# Create empty files in Benchmark
	for j in {CSVs,Logs,Results}
	do
		keepdir "${dir}"/Benchmark/${j}
	done

	# Install extra help files
	insinto "${dir}"/Help
	doins Unreal.bmp

	# Install EULA
	insinto "${dir}"
	doins UT2004_EULA.txt

	# Installing documentation/icon
	doins README.linux ut2004.xpm || die "copying readme/icon"
	dodoc README.linux || die "dodoc README.linux"
	doicon ut2004.xpm

	# Install System.inis
	insinto "${dir}"/System
	doins ini-{det,est,frt,int,itt,kot,smt,tmt}.tar

	# Copy ut2004
	exeinto "${dir}"
	doexe bin/ut2004 || die "copying ut2004"

	# Uncompressing files
	einfo "Uncompressing files... this *will* take a while..."
	for j in {Animations,Maps,Sounds,StaticMeshes,Textures}
	do
		fperms -R u+w "${dir}"/${j} || die "fperms in uncompress"
		games_ut_unpack "${Ddir}"/${j}
	done

	# Removing unneccessary files
	rm -f "${Ddir}"/Help/{InstallerLogo.bmp,SAPI-EULA.txt,{Unreal,UnrealEd}.ico}
	rm -rf "${Ddir}"/Speech/Redist
	rm -f "${Ddir}"/System/*.tar
	rm -f "${Ddir}"/System/{{License,Manifest}.smt,{ucc,StdOut}.log}
	rm -f "${Ddir}"/System/{User,UT2004,Manifest}.ini
	rm -f "${Ddir}"/System/{Manifest.int,Packages.md5}

	# Removing file collisions with ut2004-3369-r4
	rm -f "${Ddir}"/Help/UT2004Logo.bmp
	rm -f "${Ddir}"/System/{ALAudio.kot,AS-{Convoy,FallenCity,Glacier}.kot,bonuspack.{det,est,frt},BonusPack.{int,itt,u}}
	rm -f "${Ddir}"/System/{Build.ini,CacheRecords.ucl,Core.{est,frt,int,itt,u},CTF-January.kot,D3DDrv.kot,DM-1on1-Squader.kot}
	rm -f "${Ddir}"/System/{Editor,Engine,Gameplay,GamePlay,UnrealGame,UT2k4Assault,XInterface,XPickups,xVoting,XVoting,XWeapons,XWebAdmin}.{det,est,frt,int,itt,u}
	rm -f "${Ddir}"/System/{Fire.u,IpDrv.u,License.int,ONS-ArcticStronghold.kot}
	rm -f "${Ddir}"/System/{OnslaughtFull,onslaughtfull,UT2k4AssaultFull}.{det,est,frt,itt,u}
	rm -f "${Ddir}"/System/{GUI2K4,Onslaught,skaarjpack,SkaarjPack,XGame}.{det,est,frt,int,itt,kot,u}
	rm -f "${Ddir}"/System/{Setup,Window}.{det,est,frt,int,itt,kot}
	rm -f "${Ddir}"/System/XPlayers.{det,est,frt,int,itt}
	rm -f "${Ddir}"/System/{UnrealEd.u,UTClassic.u,UTV2004c.u,UTV2004s.u,UWeb.u,Vehicles.kot,Vehicles.u,Xweapons.itt}
	rm -f "${Ddir}"/System/{XAdmin.kot,XAdmin.u,XMaps.det,XMaps.est}
	rm -f "${Ddir}"/Web/ServerAdmin/{admins_home.htm,current_bots.htm,ut2003.css}
	rm -f "${Ddir}"/Web/ServerAdmin/ClassicUT/current_bots.htm
	rm -f "${Ddir}"/Web/ServerAdmin/UnrealAdminPage/{adminsframe.htm,admins_home.htm,admins_menu.htm,current_bots.htm,currentframe.htm,current_menu.htm}
	rm -f "${Ddir}"/Web/ServerAdmin/UnrealAdminPage/{defaultsframe.htm,defaults_menu.htm,footer.inc,mainmenu.htm,mainmenu_itemd.inc,rootframe.htm,UnrealAdminPage.css}
	rm -f "${Ddir}"/Web/ServerAdmin/UT2K3Stats/{admins_home.htm,current_bots.htm,ut2003stats.css}

	# Removing file collisions with ut2004-bonuspack-ece
	rm -f "${Ddir}"/Animations/{MechaSkaarjAnims,MetalGuardAnim,NecrisAnim,ONSBPAnimations}.ukx
	rm -f "${Ddir}"/Help/BonusPackReadme.txt
	rm -f "${Ddir}"/Maps/ONS-{Adara,IslandHop,Tricky,Urban}.ut2
	rm -f "${Ddir}"/Sounds/{CicadaSnds,DistantBooms,ONSBPSounds}.uax
	rm -f "${Ddir}"/StaticMeshes/{BenMesh02,BenTropicalSM01,HourAdara,ONS-BPJW1,PC_UrbanStatic}.usx
	rm -f "${Ddir}"/System/{ONS-Adara.int,ONS-IslandHop.int,ONS-Tricky.int,ONS-Urban.int,OnslaughtBP.int,xaplayersl3.upl}
	rm -f "${Ddir}"/Textures/{AW-2k4XP,BenTex02,BenTropical01,BonusParticles,CicadaTex,Construction_S}.utx
	rm -f "${Ddir}"/Textures/{HourAdaraTexor,ONSBPTextures,ONSBP_DestroyedVehicles,PC_UrbanTex,UT2004ECEPlayerSkins}.utx

	# Now, since these files are coming off a CD, the times/sizes/md5sums won't
	# be different ... that means portage will try to unmerge some files (!)
	# We run touch on ${D} so as to make sure portage doesn't do any such thing
	find "${Ddir}" -exec touch '{}' \;

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	echo
	elog "This is only the data portion of the game.  To play UT2004, you"
	elog "still need to emerge ut2004."
	echo
}
