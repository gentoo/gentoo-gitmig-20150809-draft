# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2003/ut2003-2225.ebuild,v 1.10 2003/12/15 16:21:45 wolf31o2 Exp $

inherit games

IUSE="dedicated"
DESCRIPTION="Unreal Tournament 2003 - Sequel to the 1999 Game of the Year multi-player first-person shooter"
HOMEPAGE="http://www.unrealtournament2003.com/"
SRC_URI="http://unreal.epicgames.com/linux/ut2003/${PN}lnx_2107to${PV}.sh.bin
	ftp://david.hedbor.org/ut2k3/updates/${PN}lnx_2107to${PV}.sh.bin"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"

DEPEND="virtual/glibc"
RDEPEND="dedicated? ( games-server/ut2003-ded )
	!dedicated? ( virtual/opengl )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"
	ewarn "The installed game takes about 2.7GB of space!"
	games_pkg_setup
}

src_unpack() {
	unpack_makeself || die "unpacking patch"
}

src_install() {
	dodir ${dir}
	dodir ${dir}/System

	games_get_cd System/Packages.md5
	if [ -z "${GAMES_CDROM}" ]; then
		# Disk 1
		games_verify_cd "UT2003 Disk1"
		einfo "Copying files from Disk 1..."
		cp -r ${GAMES_CD}/{Animations,ForceFeedback,Help,KarmaData,Maps,Sounds,Textures,Web} ${Ddir} || die "copying files"
		cp -r ${GAMES_CD}/System/{editorres,*.{bmp,dat,det,est,frt,ini,int,itt,md5,u,upl,url}} ${Ddir}/System || die "copying files"
		mkdir -p ${Ddir}/Benchmark/Stuff || dir "creating benchamrk folders"
		cp -r ${GAMES_CD}/Benchmark/Stuff/* ${Ddir}/Benchmark/Stuff || die "copying benchmark files"

		# Disk 2
		einfo "Please mount UT2003 Disk 2 and press return when ready (or CTRL+C to abort)"
		read
		games_get_cd StaticMeshes/AWHardware.usx.uz2
		games_verify_cd "UT2003 Disk 2"
		einfo "Copying files from Disk 2..."
		cp -r ${GAMES_CD}/{Music,Sounds,StaticMeshes,Textures} ${Ddir} || die "copying files"

		# Disk 3
		einfo "Please mount UT2003 Disk 3 and press return when ready (or CTRL+C to abort)"
		read
		games_get_cd Extras/MayaPLE/Maya4PersonalLearningEditionEpic.exe
		games_verify_cd "UT2003 Disk 3"
		einfo "Copying files from Disk 3..."
		cp -r ${GAMES_CD}/Sounds ${Ddir} || die "copying files"
	else
		# Copying from local disk
		einfo "Copying files... this may take a while..."
		cp -r ${GAMES_CD}/{Animations,ForceFeedback,Help,KarmaData,Maps,Music,Sounds,StaticMeshes,Textures,Web} ${Ddir} || die "copying files"
		cp -r ${GAMES_CD}/System/{editorres,*.{bmp,dat,det,est,frt,ini,int,itt,md5,u,upl,url}} ${Ddir}/System || die "copying files"
		mkdir -p ${Ddir}/Benchmark/Stuff || die "creating benchmark folders"
		cp -r ${GAMES_CD}/Benchmark/Stuff/* ${Ddir}/Benchmark/Stuff || die "copying benchmark files"
	fi

	# create empty files in Benchmark
	for j in {CSVs,Logs,Results} ; do
		mkdir -p ${Ddir}/Benchmark/${j} || die "creating folders"
		touch ${Ddir}/Benchmark/${j}/DO_NOT_DELETE.ME || die "creating files"
	done

	# remove Default, DefUser, UT2003 and User ini files
	rm ${Ddir}/System/{Def{ault,User},UT2003,User}.ini || die "deleting ini files"

	# unpack_makeself won't take absolute path
	unpack_makeself ${GAMES_CD}/linux_installer.sh || die "unpacking linux installer"

	# install extra help files
	insinto ${dir}/Help
	doins ${S}/Help/Unreal.bmp

	# install Default and DefUser ini files
	insinto ${dir}/System
	doins ${S}/System/Def{ault,User}.ini

	# install eula
	insinto ${dir}
	doins ${S}/eula/License.int

	# uncompress original binaries/libraries
	tar -xf ut2003lnxbins.tar || die "unpacking original binaries/libraries"

	# copying extra/updater
	cp -r ${S}/{extras,updater} ${Ddir} || die "copying extras/updater"

	# install benchmarks
	#exeinto ${dir}/Benchmark
	cp -r ${S}/Benchmark/botmatch-* ${S}/Benchmark/flyby-* ${Ddir}/Benchmark || die "copying benchmark files"

	# copy ut2003/ucc
	exeinto ${dir}
	doexe ${S}/bin/ut2003 ${S}/ucc || die "copying ut2003/ucc"

	# copy binaries/libraries
	exeinto ${dir}/System
	doexe ${S}/System/{*-bin,*.so.0,*.so} || die "copying system binaries/libraries"

	# uncompressing files
	einfo "Uncompressing files... this may take a while..."
	for j in {Animations,Maps,Sounds,StaticMeshes,Textures} ; do
		games_ut_unpack ${Ddir}/${j} || die "uncompressing files"
	done

	# installing documentation/icon
	dodoc ${S}/README.linux || die "dodoc README.linux"
	insinto /usr/share/pixmaps ; newins ${S}/Unreal.xpm UT2003.xpm || die "copying pixmap"
	insinto ${dir}
	doins ${S}/README.linux ${S}/Unreal.xpm || die "copying readme/icon"

	sed -e "s:GENTOO_DIR:${dir}:" ${FILESDIR}/ucc > ucc
	sed -e "s:GENTOO_DIR:${dir}:" ${FILESDIR}/ut2003 > ut2003
	dogamesbin ucc ut2003

	rm ${Ddir}/System/{UT2003,User}.ini || die "deleting ini files"

	# this brings our install up to the newest version
	cd ${S}
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	prepgamesdirs
	make_desktop_entry ut2003 "UT2003" UT2003.xpm
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
	einfo " ut2003"
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
	einfo "CD key format is: XXXX-XXXX-XXXX-XXXX"
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
