# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/unreal/unreal-226.ebuild,v 1.7 2004/02/09 05:06:11 vapier Exp $

inherit games eutils

DESCRIPTION="Futuristic FPS (a hack that runs on top of Unreal Tournament)"
HOMEPAGE="http://www.unreal.com/ http://icculus.org/~chunky/ut/unreal/"
SRC_URI="http://www.icculus.org/%7Echunky/ut/unreal/unreali-install.run
	ftp://ftp.lokigames.com/pub/patches/ut/ut-install-436.run
	ftp://ftp.lokigames.com/pub/patches/ut/IpDrv-436-Linux-08-20-02.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="X"

DEPEND="|| ( games-fps/unreal-tournament games-fps/unreal-tournament-goty )
	sys-libs/lib-compat"
RDEPEND="X? ( virtual/x11 )
	opengl? ( virtual/opengl )"

S=${WORKDIR}

pkg_setup() {
	export CDROM_NAME_1="Unreal CD"
	export CDROM_NAME_2="Unreal Tournament CD"
	cdrom_get_cds System/Unreal.ini System/UnrealTournament.ini
	games_pkg_setup
}

src_unpack() {
	unpack_makeself unreali-install.run
	mkdir ut
	cd ut
	unpack_makeself ut-install-436.run
	unpack IpDrv-436-Linux-08-20-02.zip
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/unreal
	dodir ${dir}

	tar -zxf ut/data.tar.gz -C ${D}/${dir}
	tar -zxf ut/OpenGL.ini.tar.gz -C ${D}/${dir}
	tar -zxf System.tar.gz -C ${D}/${dir}
	insinto ${dir}/System
	doins ut/IpDrv.so

	cp -rf ${CDROM_ROOT}/{Maps,Music,Sounds} ${D}/${dir}/
	for f in ${D}/${dir}/Maps/Dm*.unr ; do
		mv ${f} ${f/Dm/DM-}
	done
	dosym Maps ${dir}/maps

	if has_version '<games-fps/unreal-tournament-451' \
		|| has_version '<games-fps/unreal-tournament-goty-451' ; then
		CDROM_ROOT="${GAMES_PREFIX_OPT}/unreal-tournament"
	else
		cdrom_load_next_cd
	fi
	insinto ${dir}/Textures
	doins ${CDROM_ROOT}/Textures/*.utx
	insinto ${dir}/Sounds
	doins ${CDROM_ROOT}/Sounds/*.uax
	insinto ${dir}/System
	doins ${CDROM_ROOT}/System/*.u
	insinto ${dir}/Music
	doins ${CDROM_ROOT}/Music/*.umx

	insinto ${dir}
	doins icon.* README*

	exeinto ${dir}
	doexe bin/x86/unreal

	games_make_wrapper unreal ./unreal ${dir}

	prepgamesdirs
}
