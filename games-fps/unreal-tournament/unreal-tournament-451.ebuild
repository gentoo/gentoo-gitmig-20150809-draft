# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/unreal-tournament/unreal-tournament-451.ebuild,v 1.20 2006/04/14 11:50:58 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Futuristic FPS"
HOMEPAGE="http://www.unrealtournament.com/ http://utpg.org/"
SRC_URI="ftp://ftp.lokigames.com/pub/patches/ut/ut-install-436.run
	http://utpg.org/patches/UTPGPatch${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="3dfx opengl"

RDEPEND="!amd64? (
		|| (
			(
				x11-libs/libXext
				x11-libs/libX11
				x11-libs/libXau
				x11-libs/libXdmcp )
			virtual/x11 )
		=media-libs/libsdl-1.2*
		opengl? ( virtual/opengl ) )
	amd64? ( app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"

DEPEND="${RDEPEND}
	!games-fps/unreal-tournament-goty"

S="${WORKDIR}"

pkg_setup() {
	games_pkg_setup
	cdrom_get_cds System/
}

src_unpack() {
	unpack_makeself ut-install-436.run
	mkdir UTPG && cd UTPG
	unpack UTPGPatch${PV}.tar.bz2
	rm checkfiles.sh patch.md5
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	local Ddir=${D}/${dir}
	dodir ${dir}

	# Help, Logs, Music, Textures, Web
	cp -rf ${CDROM_ROOT}/{Help,Logs,Music,Textures,Web} ${Ddir}/ || die "copy Help, Logs, Music, Textures, Web"
	tar -zxf Credits.tar.gz -C ${Ddir} || die "extract credits texture"
	# NetGamesUSA.com
	tar -zxf NetGamesUSA.com.tar.gz -C ${Ddir}/ || die "extract NetGamesUSA.com"
	# Sounds
	dodir ${dir}/Sounds
	cp -rf ${CDROM_ROOT}/Sounds/*.uax ${Ddir}/Sounds/ || die "copy Sounds"

	# System
	if use 3dfx ; then
		tar -zxf Glide.ini.tar.gz -C ${Ddir} || die "install Glide ini"
	else
		tar -zxf OpenGL.ini.tar.gz -C ${Ddir} || die "install OpenGL ini"
	fi
	tar -zxf data.tar.gz -C ${Ddir} || die "extract System data"
	cp ${CDROM_ROOT}/System/*.u ${Ddir}/System/ || die "copy System data"

	# the most important things, ucc & ut :)
	exeinto ${dir}
	doexe bin/x86/{ucc,ut} || die "install ucc/ut"
	dosed "s:\`FindPath \$0\`:${dir}:" ${dir}/ucc

	# install a few random files
	insinto ${dir}
	doins README icon.{bmp,xpm} || die "installing random files"

	# install a menu item (closes bug #27542)
	insinto /usr/share/pixmaps
	newins icon.xpm ut.xpm
	make_desktop_entry ut "Unreal Tournament" ut.xpm

	# first apply any patch remaints loki has for us
	cd setup.data
	./bin/Linux/x86/loki_patch patch.dat ${Ddir} >& /dev/null
	cd ${S}

	# finally, unleash the UTPG patch
	cp -rf UTPG/* ${Ddir}/
	# fix a small bug until next official release
	dosed "/^LoadClassMismatch/s:%s.%s:%s:" ${dir}/System/Core.int

	# now we uncompress the maps (GOTY edition installs maps as .uz)
	einfo "Uncompressing Maps ... this may take some time"
	dodir ${dir}/Maps
	cd ${Ddir}
	export HOME=${T}
	export UT_DATA_PATH=${Ddir}/System
	for f in `find ${CDROM_ROOT}/Maps/ -name '*.uz' -printf '%f '` ; do
		./ucc decompress ${CDROM_ROOT}/Maps/${f} -nohomedir || die "uncompressing map ${f}"
		mv System/${f:0:${#f}-3} Maps/ || die "copy map ${f}"
	done
	cp -rf ${CDROM_ROOT}/Maps/*.unr ${Ddir}/Maps/ # some cd's have uncompressed maps ??

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	# export some symlinks so ppl can run
	dodir ${GAMES_BINDIR}
	dosym ${dir}/ut ${GAMES_BINDIR}/ut

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "You might want to install the bonus packs too."
	einfo "Many servers on the internet use them, and the"
	einfo "majority of players do too."
	echo
	einfo "Just run: emerge unreal-tournament-bonuspacks"
	echo
}
