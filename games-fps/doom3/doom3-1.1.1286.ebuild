# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3/doom3-1.1.1286.ebuild,v 1.1 2004/11/26 21:28:57 wolf31o2 Exp $

inherit games eutils

DESCRIPTION="Doom III - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/${PN}/linux/${PN}-linux-${PV}.x86.run
	ftp://dl.xs4all.nl/pub/mirror/idsoftware/idstuff/${PN}/linux/${PN}-linux-${PV}.x86.run"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE="cdinstall alsa opengl dedicated"
RESTRICT="nostrip"

DEPEND="app-arch/bzip2
	app-arch/tar"
RDEPEND="virtual/libc
	opengl? ( virtual/opengl )
	dedicated? ( app-misc/screen )
	alsa? ( >=media-libs/alsa-lib-1.0.6 )
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-nvidia	)"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license
	use cdinstall && cdrom_get_cds Setup/Data/base/pak002.pk4 \
		Setup/Data/base/pak000.pk4 \
		 Setup/Data/base/pak003.pk4
	games_pkg_setup
}

src_unpack() {
	unpack_makeself ${PN}-linux-${PV}.x86.run
}

src_install() {
	dodir ${dir}

	insinto ${dir}
	doins License.txt README version.info doom3.png
	exeinto ${dir}
	doexe libgcc_s.so.1 libstdc++.so.5 || die "doexe libs"
	doexe openurl.sh || die "openurl.sh"
	if use x86; then
		doexe bin/Linux/x86/doom{,ded}.x86 || die "doexe x86 exes"
	elif use amd64; then
		doexe bin/Linux/amd64/doom{,ded}.x86 || die "doexe amd64 exes"
	else
		die "Cannot copy executables!"
	fi

	insinto ${dir}/base
	doins base/* || die "doins base"
	if use cdinstall; then
		einfo "Copying files from Disk 1..."
		doins ${CDROM_ROOT}/Setup/Data/base/pak002.pk4 \
			|| die "copying pak002"
		cdrom_load_next_cd
		einfo "Copying files from Disk 2..."
		doins ${CDROM_ROOT}/Setup/Data/base/pak00* \
			|| die "copying pak000 and pak001"
		cdrom_load_next_cd
		einfo "Copying files from Disk 3..."
		doins ${CDROM_ROOT}/Setup/Data/base/pak00* \
			|| die "copying pak003 and pak004"
	fi

	games_make_wrapper doom3 ./doom.x86 ${dir}
	games_make_wrapper doom3-ded ./doomded.x86 ${dir}

	use cdinstall && find ${Ddir} -exec touch '{}' \;

	insinto /usr/share/pixmaps
	doins doom3.png

	prepgamesdirs
	make_desktop_entry doom3 "Doom III" doom3.png
}

pkg_postinst() {
	games_pkg_postinst

	if use cdinstall; then
		einfo "To play the game run:"
		einfo " doom3"
	else
		einfo "You need to copy pak000.pk4, pak001.pk4, pak002.pk4, pak003.pk4, and"
		einfo "pak004.pk4 from either your installation media or your hard drive to"
		einfo "${dir}/base before running the game."
		echo
		einfo "To play the game run:"
		einfo " doom3"
	fi
}
