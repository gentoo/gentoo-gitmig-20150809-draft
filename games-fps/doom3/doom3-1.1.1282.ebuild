# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3/doom3-1.1.1282.ebuild,v 1.3 2004/10/06 13:06:12 vapier Exp $

inherit games eutils

DESCRIPTION="Doom III - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/doom3/linux/${PN}-linux-${PV}.x86.run"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE="cdinstall opengl dedicated"
RESTRICT="nostrip"

DEPEND="app-arch/bzip2
	app-arch/tar"
RDEPEND="virtual/libc
	opengl? ( virtual/opengl )
	dedicated? ( app-misc/screen )
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
	unpack_makeself
}

src_install() {
	dodir ${dir}

	insinto ${dir}
	doins License.txt README version.info
	exeinto ${dir}
	doexe libgcc_s.so.1 libstdc++.so.5 || die "doexe libs"
	doexe bin/Linux/x86/glibc-2.1/doom{,ded}.x86 || die "doexe exes"

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

	prepgamesdirs
	make_desktop_entry doom3 "Doom III" doom3.xpm
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

	# IA32 Emulation required for amd64
	if use amd64 ; then
		echo
		ewarn "NOTE: IA32 Emulation must be compiled into your kernel for Doom3 to run."
	fi
}
