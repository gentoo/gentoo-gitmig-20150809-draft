# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004/ut2004-3323.ebuild,v 1.3 2004/11/17 18:59:38 wolf31o2 Exp $

inherit games

MY_P="${PN}-lnxpatch${PV}.tar.bz2"
DESCRIPTION="Unreal Tournament 2004 - follow-up to the 2003  multi-player first-person shooter"
HOMEPAGE="http://www.unrealtournament2004.com/"
SRC_URI="mirror://3dgamers/pub/3dgamers5/games/unrealtourn2k4/${MY_P}
	mirror://3dgamers/pub/3dgamers/games/unrealtourn2k4/${MY_P}
	http://iadfillvip.xlontech.net/100083/games/unrealtourn2k4/${MY_P}
	http://mirror1.icculus.org/${PN}/${MY_P}"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="x86 amd64"
RESTRICT="nostrip"
IUSE="opengl dedicated"

DEPEND="virtual/libc
	games-util/uz2unpack"
RDEPEND="opengl? ( virtual/opengl )
	dedicated? ( app-misc/screen )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"
	ewarn "The installed game takes about 6.8GB of space!"

	# The following is a nasty mess to determine if we are installing from
	# a DVD or from multiple CDs.  Anyone feel free to submit patches to this
	# to bugs.gentoo.org as I know it is a very ugly hack.
	USE_DVD=
	if [ -n "${CD_ROOT}" ]; then
		[ -d "${CD_ROOT}/CD1" ] && USE_DVD=1
	else
		local mline=""
		for mline in `mount | egrep -e '(iso|cdrom)' | awk '{print $3}'` ; do
			[ -d "${mline}/CD1" ] && USE_DVD=1
		done
	fi
	if [ ${USE_DVD} ]; then
		DISK1="CD1"
		DISK2="CD2"
		DISK3="CD3"
		DISK4="CD4"
		DISK5="CD5"
		DISK6="CD6"
	fi
	cdrom_get_cds ${DISK1}/System/UT2004.ini \
		${DISK2}/Textures/2K4Fonts.utx.uz2 \
		${DISK3}/Textures/ONSDeadVehicles-TX.utx.uz2 \
		${DISK4}/Music/KR-UT2004-Menu.ogg \
		${DISK5}/Speech/ons.xml ${DISK6}/DirectX9/BDA.cab

	games_pkg_setup
}

src_unpack() {
	unpack_makeself ${CDROM_ROOT}/linux-installer.sh \
		|| die "unpacking linux installer"
	use x86 && tar -xf ${S}/linux-x86.tar
	use amd64 && tar -xf ${S}/linux-amd64.tar
	unpack ${MY_P}
}

src_install() {
	dodir ${dir}/System/editorres

	# Disk 1
	einfo "Copying files from Disk 1..."
	cp -r ${CDROM_ROOT}/${DISK1}/{Animations,ForceFeedback,Help,KarmaData,Maps,Sounds,Web} ${Ddir} || die "copying files"
	cp -r ${CDROM_ROOT}/${DISK1}/System/{editorres,*.{bat,bmp,dat,det,est,frt,ini,int,itt,kot,md5,smt,tmt,u,ucl,upl,url}} ${Ddir}/System || die "copying files"
	mkdir -p ${Ddir}/Manual || die "creating manual folder"
	cp ${CDROM_ROOT}/${DISK1}/Manual/Manual.pdf ${Ddir}/Manual \
		|| die "copying manual"
	mkdir -p ${Ddir}/Benchmark/Stuff || die "creating benchmark folders"
	cp -r ${CDROM_ROOT}/${DISK1}/Benchmark/Stuff/* ${Ddir}/Benchmark/Stuff \
		|| die "copying benchmark files"
	cdrom_load_next_cd

	# Disk 2
	einfo "Copying files from Disk 2..."
	cp -r ${CDROM_ROOT}/${DISK2}/{Sounds,Textures} ${Ddir} || die "copying files"
	cdrom_load_next_cd

	# Disk 3
	einfo "Copying files from Disk 3..."
	cp -r ${CDROM_ROOT}/${DISK3}/Textures ${Ddir} || die "copying files"
	cdrom_load_next_cd

	#Disk 4
	einfo "Copying files from Disk 4..."
	cp -r ${CDROM_ROOT}/${DISK4}/{Music,StaticMeshes,Textures} ${Ddir} \
		|| die "copying files"
	cdrom_load_next_cd

	#Disk 5
	einfo "Copying files from Disk 5..."
	cp -r ${CDROM_ROOT}/${DISK5}/{Music,Sounds} ${Ddir} \
		|| die "copying files"
	cdrom_load_next_cd

	#Disk 6
	einfo "Copying files from Disk 6..."
	cp -r ${CDROM_ROOT}/${DISK6}/Sounds ${Ddir} \
		|| die "copying files"

	# create empty files in Benchmark
	for j in {CSVs,Logs,Results} ; do
		mkdir -p ${Ddir}/Benchmark/${j} || die "creating folders"
		touch ${Ddir}/Benchmark/${j}/DO_NOT_DELETE.ME || die "creating files"
	done

	# install extra help files
	insinto ${dir}/Help
	doins ${S}/Unreal.bmp ${S}/UT2004Logo.bmp

	# install eula
	insinto ${dir}
	doins ${S}/UT2004_EULA.txt

	# install System.inis
	insinto ${dir}/System
	doins ${S}/ini-{det,est,frt,int,itt,kot,smt,tmt}.tar

	# copy ut2004
	exeinto ${dir}
	doexe ${S}/bin/ut2004 || die "copying ut2004"

	exeinto ${dir}/System
	doexe ${S}/System/{libSDL-1.2.so.0,openal.so,u{cc,t2004}-bin} \
		|| die "copying libs/ucc/ut2004"

	# Removing uneccessary files in Sounds
	rm -f ${Ddir}/Sounds/*.{det,est,frt,itt,kot,smt,tmt}_uax.uz2

	# Installing patch files (first time) for decompress
	cp ${S}/UT2004-Patch/System/* ${Ddir}/System
	use amd64 && rm ${Ddir}/System/ucc-bin && \
		mv ${Ddir}/System/ucc-bin-linux-amd64 ${Ddir}/System/ucc-bin

	# uncompressing files
	einfo "Uncompressing files... this *will* take a while..."
	for j in {Animations,Maps,Sounds,StaticMeshes,Textures} ; do
		chmod -R u+w ${Ddir}/${j} || die "chmod in uncompress"
		games_ut_unpack ${Ddir}/${j} || die "uncompressing files"
	done

	# Installing patch files
	for p in {Animations,Help,System,Textures,Web}; do
		cp -r ${S}/UT2004-Patch/${p}/* ${Ddir}/${p} \
			|| die "copying ${p} from patch."
	done

	use amd64 && rm ${Ddir}/System/u{cc,t2004}-bin \
		&& mv ${Ddir}/System/ucc-bin-linux-amd64 ${Ddir}/System/ucc-bin \
		&& mv ${Ddir}/System/ut2004-bin-linux-amd64 ${Ddir}/System/ut2004-bin \
		&& chmod ug+x ${Ddir}/System/ucc-bin ${Ddir}/System/ut2004-bin
	use x86 && rm ${Ddir}/System/ucc-bin-linux-amd64 \
		${Ddir}/System/ut2004-bin-linux-amd64

	# Removing unneccessary files in System and Help
	rm -f ${Ddir}/Help/{InstallerLogo.bmp,SAPI-EULA.txt,{Unreal,UnrealEd}.ico}
	rm -f ${Ddir}/System/*.tar
	rm -f ${Ddir}/System/{{License,Manifest}.smt,{ucc,StdOut}.log,{User,UT2004}.ini}

	# installing documentation/icon
	dodoc ${S}/README.linux || die "dodoc README.linux"
	insinto /usr/share/pixmaps;
	doins ${S}/ut2004.xpm || die "copying pixmap"
	insinto ${dir}
	doins ${S}/README.linux ${S}/ut2004.xpm || die "copying readme/icon"

	# creating .manifest files
	insinto ${dir}/.manifest
	doins ${FILESDIR}/${PN}.xml

	# creating .loki/installed links
	mkdir -p ${D}/root/.loki/installed
	dosym ${dir}/.manifest/${PN}.xml /root/.loki/installed/${PN}.xml

	games_make_wrapper ut2004 ./ut2004 ${dir}

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	prepgamesdirs
	make_desktop_entry ut2004 "Unreal Tournament 2004" ut2004.xpm
}

pkg_postinst() {
	games_pkg_postinst

	# here is where we check for the existence of a cdkey...
	# if we don't find one, we ask the user for it
	if [ -f ${dir}/System/cdkey ]; then
		einfo "A cdkey file is already present in ${dir}/System"
	else
		ewarn "You MUST run this before playing the game:"
		ewarn "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
		ewarn "That way you can [re]enter your cdkey."
	fi
	echo
	einfo "To play the game run:"
	einfo " ut2004"
	echo
}

pkg_postrm() {
	ewarn "This package leaves a cdkey file in ${dir}/System that you need"
	ewarn "to remove to completely get rid of this game's files."
}

pkg_config() {
	ewarn "Your CD key is NOT checked for validity here."
	ewarn "  Make sure you type it in correctly."
	eerror "If you CTRL+C out of this, the game will not run!"
	echo
	einfo "CD key format is: XXXXX-XXXXX-XXXXX-XXXXX"
	while true ; do
		einfo "Please enter your CD key:"
		read CDKEY1
		einfo "Please re-enter your CD key:"
		read CDKEY2
		if [ "$CDKEY1" == "" ] ; then
			echo "You entered a blank CD key.  Try again."
		else
			if [ "$CDKEY1" == "$CDKEY2" ] ; then
				echo "$CDKEY1" | tr a-z A-Z > ${dir}/System/cdkey
				einfo "Thank you!"
				break
			else
				eerror "Your CD key entries do not match.  Try again."
			fi
		fi
	done
}
