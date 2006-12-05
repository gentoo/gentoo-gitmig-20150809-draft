# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/unreal-tournament/unreal-tournament-436.ebuild,v 1.15 2006/12/05 18:07:38 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Futuristic FPS"
HOMEPAGE="http://www.unrealtournament.com/"
SRC_URI="ftp://ftp.lokigames.com/pub/patches/ut/ut-install-${PV}.run
	ftp://ftp.lokigames.com/pub/patches/ut/IpDrv-${PV}-Linux-08-20-02.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="3dfx"

DEPEND="app-arch/unzip
	!games-fps/unreal-tournament-goty"
RDEPEND="x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp"

S=${WORKDIR}

src_unpack() {
	cdrom_get_cds System/
	unpack_makeself ut-install-${PV}.run
	unpack IpDrv-${PV}-Linux-08-20-02.zip
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	# Help, Logs, Music, Textures, Web
	cp -rf ${CDROM_ROOT}/{Help,Logs,Music,Textures,Web} ${D}/${dir}/ || die "copy Help, Logs, Music, Textures, Web"
	tar -zxf Credits.tar.gz -C ${D}/${dir} || die "extract credits texture"
	# NetGamesUSA.com
	tar -zxf NetGamesUSA.com.tar.gz -C ${D}/${dir}/ || die "extract NetGamesUSA.com"
	# Sounds
	dodir ${dir}/Sounds
	cp -rf ${CDROM_ROOT}/Sounds/*.uax ${D}/${dir}/Sounds/ || die "copy Sounds"

	# System
	if use 3dfx ; then
		tar -zxf Glide.ini.tar.gz -C ${D}/${dir} || die "install Glide ini"
	else
		tar -zxf OpenGL.ini.tar.gz -C ${D}/${dir} || die "install OpenGL ini"
	fi
	tar -zxf data.tar.gz -C ${D}/${dir} || die "extract System data"
	cp ${CDROM_ROOT}/System/*.u ${D}/${dir}/System/ || die "copy System data"

	# the most important things, ucc & ut :)
	exeinto ${dir}
	doexe bin/x86/{ucc,ut} || die "install ucc/ut"
	dosed "s:\`FindPath \$0\`:${dir}:" ${dir}/ucc

	# now we install the IpDrv.so patch
	insinto ${dir}/System
	doins IpDrv.so || die "install IpDrv.so patch"

	# install a few random files
	insinto ${dir}
	doins README icon.{bmp,xpm} || die "installing random files"

	# install a menu item (closes bug #27542)
	insinto /usr/share/pixmaps
	newins icon.xpm ut.xpm
	make_desktop_entry ut "Unreal Tournament" ut.xpm

	# now we uncompress the maps (GOTY edition installs maps as .uz)
	einfo "Uncompressing Maps ... this may take some time"
	dodir ${dir}/Maps
	cd ${D}/${dir}
	export HOME=${T}
	export UT_DATA_PATH=${D}/${dir}/System
	for f in `find ${CDROM_ROOT}/Maps/ -name '*.uz' -printf '%f '` ; do
		./ucc decompress ${CDROM_ROOT}/Maps/${f} -nohomedir || die "uncompressing map ${f}"
		mv System/${f:0:${#f}-3} Maps/ || die "copy map ${f}"
	done
	cp -rf ${CDROM_ROOT}/Maps/*.unr ${D}/${dir}/Maps/ # some cd's have uncompressed maps ??

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
