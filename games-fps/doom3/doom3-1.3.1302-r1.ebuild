# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3/doom3-1.3.1302-r1.ebuild,v 1.6 2006/03/22 15:11:38 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="mirror://3dgamers/${PN}/${PN}-linux-${PV}.x86.run
	mirror://idsoftware/${PN}/linux/${PN}-linux-${PV}.x86.run
	http://zerowing.idsoftware.com/linux/${PN}.png"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="cdinstall alsa dedicated opengl roe"
RESTRICT="nostrip"

DEPEND="app-arch/bzip2
	app-arch/tar"
RDEPEND="sys-libs/glibc
	opengl? ( virtual/opengl )
	dedicated? ( app-misc/screen )
	alsa? ( >=media-libs/alsa-lib-1.0.6 )
	cdinstall? ( games-fps/doom3-data )
	amd64? ( app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	if use cdinstall && use roe
	then
		built_with_use games-fps/doom3-data roe || \
			die "You must emerge games-fps/doom3-data with USE=roe"
	fi
}

src_unpack() {
	unpack_makeself ${PN}-linux-${PV}.x86.run
}

src_install() {
	insinto "${dir}"
	doins License.txt CHANGES README version.info doom3.png
	exeinto "${dir}"
	doexe libgcc_s.so.1 libstdc++.so.5 || die "doexe libs"
	doexe openurl.sh || die "openurl.sh"
	if use x86; then
		doexe bin/Linux/x86/doom{,ded}.x86 || die "doexe x86 exes"
	elif use amd64; then
		doexe bin/Linux/amd64/doom{,ded}.x86 || die "doexe amd64 exes"
	else
		die "Cannot copy executables!"
	fi

	insinto "${dir}"/pb
	doins pb/* || die "doins pb"
	if use roe
	then
		insinto "${dir}"/d3xp
		doins d3xp/* || die "doins d3xp"
	fi
	insinto "${dir}"/base
	doins base/* || die "doins base"

	games_make_wrapper doom3 ./doom.x86 "${dir}" "${dir}"
	games_make_wrapper doom3-ded ./doomded.x86 "${dir}" "${dir}"

	doicon ${DISTDIR}/doom3.png || die "Copying icon"

	prepgamesdirs
	make_desktop_entry doom3 "Doom III" doom3.png
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall; then
		einfo "You need to copy pak000.pk4, pak001.pk4, pak002.pk4, pak003.pk4, and"
		einfo "pak004.pk4 from either your installation media or your hard drive to"
		einfo "${dir}/base before running the game."
		echo
		if use roe
		then
			einfo "To use the Ressurection of Evil expansion pack, you also need to copy"
			einfo "pak000.pk4 to ${dir}/d3xp before running the game."
		fi
	fi
	echo
	einfo "To play the game run:"
	einfo " doom3"
	echo
}
