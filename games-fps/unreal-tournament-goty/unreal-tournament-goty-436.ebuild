# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/unreal-tournament-goty/unreal-tournament-goty-436.ebuild,v 1.1 2003/09/09 18:10:15 vapier Exp $

inherit games eutils

DESCRIPTION="Futuristic FPS (Game Of The Year edition)"
HOMEPAGE="http://www.unrealtournament.com/"
SRC_URI="ftp://ftp.lokigames.com/pub/beta/ut/ut-install-${PV}-GOTY.run
	ftp://ftp.lokigames.com/pub/patches/ut/IpDrv-${PV}-Linux-08-20-02.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="X 3dfx S3TC nls"

DEPEND="!app-games/unreal-tournament"
RDEPEND="X? ( virtual/x11 )"

S=${WORKDIR}

export UT_CD1=${UT_SETUP_CDROM1}
export UT_CD2=${UT_SETUP_CDROM2}
if [ -z "${UT_CD1}" ] ; then
	for mline in `mount | egrep -e '(iso|cdrom)' | awk '{print $3}'` ; do
		[ ! -d ${mline}/System ] && continue
		[ -d ${mline}/Help/chaosut ] \
			&& UT_CD2=${mline} \
			|| UT_CD1=${mline}
	done
fi
[ -z "${UT_CD2}" ] && UT_CD2=${UT_CD1}

pkg_setup() {
	if [ -z "${UT_CD1}" ] || [ -z "${UT_CD2}" ] ; then
		echo
		eerror "You must mount the first UT CD first !"
		echo
		ewarn "If you do not have the CDs, but have the data files"
		ewarn "mounted somewhere on your filesystem, just export"
		ewarn "the variable UT_SETUP_CDROM1 so that it points to the"
		ewarn "base of the Unreal Tournament GOTY data."
		echo
		einfo "If you have 2 CDROM drives you can also export the"
		einfo "variable UT_SETUP_CDROM2 to specify the 2nd cdrom."
		einfo "Otherwise you will be prompted to switch CDs in the"
		einfo "middle of the emerge."
		echo
		einfo "Also note that if you want to *just* install the game"
		einfo "and *not* install the extra GOTY stuff (Chaos mod/different"
		einfo "languages/S3TC textures) then you can use the regular"
		einfo "unreal-tournament ebuild instead."
		echo
		die "You must provide the Unreal Tournament data before running the install"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack_makeself ut-install-${PV}-GOTY.run
	unpack IpDrv-${PV}-Linux-08-20-02.zip
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN/-goty/}
	dodir ${dir}

	###########
	### PRE ###
	# System
	if [ `use 3dfx` ] ; then
		tar -zxf Glide.ini.tar.gz -C ${D}/${dir} || die "install Glide ini"
	else
		tar -zxf OpenGL.ini.tar.gz -C ${D}/${dir} || die "install OpenGL ini"
	fi
	tar -zxf data.tar.gz -C ${D}/${dir} || die "extract System data"

	# the most important things, ucc & ut :)
	exeinto ${dir}
	doexe bin/x86/{ucc,ut} || die "install ucc/ut"
	dosed "s:\`FindPath \$0\`:${dir}:" ${dir}/ucc

	# export some symlinks so ppl can run
	dodir ${GAMES_BINDIR}
	dosym ${dir}/ucc ${GAMES_BINDIR}/ucc
	dosym ${dir}/ut ${GAMES_BINDIR}/ut
	### PRE ###
	###########


	###########
	### CD1 ###
	export UT_CD=${UT_CD1}

	# Help, Logs, Music, Sounds, Textures, Web
	cp -rf ${UT_CD}/{Help,Logs,Music,Textures,Web} ${D}/${dir}/ || die "copy Help, Logs, Music, Textures, Web CD1"
	dodir ${dir}/Sounds
	if [ `use nls` ] ; then
		cp -rf ${UT_CD}/Sounds/* ${D}/${dir}/Sounds/ || die "copy Sounds CD1"
	else
		cp -rf ${UT_CD}/Sounds/*.uax ${D}/${dir}/Sounds/ || die "copy Sounds CD1"
	fi

	# System
	dodir ${dir}/System
	if [ `use nls` ] ; then
		cp ${UT_CD}/System/*.{est,frt,itt,int,u} ${D}/${dir}/System/ || die "copy System data CD1"
	else
		cp ${UT_CD}/System/*.{int,u} ${D}/${dir}/System/ || die "copy System data CD1"
	fi

	# now we uncompress the maps
	einfo "Uncompressing CD1 Maps ... this may take some time"
	dodir ${dir}/Maps
	cd ${D}/${dir}
	export HOME=${T}
	export UT_DATA_PATH=${D}/${dir}/System
	for f in `find ${UT_CD}/Maps/ -name '*.uz' -printf '%f '` ; do
		./ucc decompress ${UT_CD}/Maps/${f} -nohomedir || die "uncompressing map CD1 ${f}"
		mv System/${f:0:${#f}-3} Maps/ || die "copy map CD1 ${f}"
	done
	### CD1 ###
	###########


	### Have user switch cds if need be ###
	if [ "${UT_CD1}" == "${UT_CD2}" ] ; then
		while :; do
			einfo "Please mount the 2nd cd at ${UT_CD2} and press return when ready (or CTRL+C to abort)"
			read
			[ -d ${UT_CD2}/System ] && break
			[ -d ${UT_CD2}/Help/chaosut ] && break
			eerror "Could not verify that ${UT_CD2} really contains the 2nd CD"
		done
	fi


	###########
	### CD2 ###
	export UT_CD=${UT_CD2}

	# Help, Sounds
	cp -rf ${UT_CD}/{Help,Sounds} ${D}/${dir}/ || die "copy Help, Sounds CD2"

	# S3TC Textures
	if [ `use S3TC` ] ; then
		cp -rf ${UT_CD}/Textures ${D}/${dir}/ || die "copy S3TC Textures CD2"
	else
		cp -rf ${UT_CD}/Textures/{JezzTex,Jezztex2,SnowDog,chaostex{,2}}.utx ${D}/${dir}/Textures/ || die "copy Textures CD2"
	fi

	# System
	cp -rf ${UT_CD}/System/*.{u,int} ${D}/${dir}/System/ || die "copy System CD2"

	# now we uncompress the maps
	einfo "Uncompressing CD2 Maps ... this may take some time"
	dodir ${dir}/Maps
	cd ${D}/${dir}
	export HOME=${T}
	export UT_DATA_PATH=${D}/${dir}/System
	for f in `find ${UT_CD}/maps/ -name '*.uz' -printf '%f '` ; do
		./ucc decompress ${UT_CD}/maps/${f} -nohomedir || die "uncompressing map CD2 ${f}"
		mv System/${f:0:${#f}-3} Maps/ || die "copy map CD2 ${f}"
	done
	### CD2 ###
	###########


	###########
	### END ###
	cd ${S}

	# Textures
	tar -zxf Credits.tar.gz -C ${D}/${dir} || die "extract credits texture"
	# NetGamesUSA.com
	tar -zxf NetGamesUSA.com.tar.gz -C ${D}/${dir}/ || die "extract NetGamesUSA.com"

	# Patch UT-GOTY
	cd setup.data
	cp patch.dat{,.orig}
	sed -e 's:sh uz-maps.sh:echo:' patch.dat.orig > patch.dat
	./bin/Linux/x86/loki_patch patch.dat ${D}/${dir} || die "failed to patch"
	cd ${S}

	# now we install the IpDrv.so patch
	insinto ${dir}/System
	doins IpDrv.so || die "install IpDrv.so patch"

	# install a few random files
	insinto ${dir}
	doins README icon.{bmp,xpm} || die "installing random files"
	### END ###
	###########

	prepgamesdirs
}

pkg_postinst() {
	echo
	einfo "You might want to install the bonus packs too."
	einfo "Many servers on the internet use them, and the"
	einfo "majority of players do too."
	echo
	einfo "Just run: emerge unreal-tournament-bonuspacks"
	echo

	games_pkg_postinst
}
