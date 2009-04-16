# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3/doom3-1.3.1302-r2.ebuild,v 1.13 2009/04/16 12:37:36 nyhm Exp $

inherit eutils games

DESCRIPTION="3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="mirror://3dgamers/${PN}/${PN}-linux-${PV}.x86.run
	mirror://idsoftware/${PN}/linux/${PN}-linux-${PV}.x86.run
	http://zerowing.idsoftware.com/linux/${PN}.png"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="alsa dedicated cdinstall opengl roe"
RESTRICT="strip"
PROPERTIES="interactive"

DEPEND="app-arch/bzip2
	app-arch/tar"
RDEPEND="sys-libs/glibc
	opengl? ( virtual/opengl )
	alsa? ( >=media-libs/alsa-lib-1.0.6 )
	cdinstall? ( >=games-fps/doom3-data-1.1.1282-r1 )
	cdinstall? ( roe? ( games-fps/doom3-roe ) )
	amd64? ( app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

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
		if use dedicated; then
			doexe bin/Linux/x86/doom{,ded}.x86 || die "doexe x86 exes"
		else
			doexe bin/Linux/x86/doom.x86 || die "doexe x86 exes"
		fi
	elif use amd64; then
		if use dedicated; then
			doexe bin/Linux/amd64/doom{,ded}.x86 || die "doexe amd64 exes"
		else
			doexe bin/Linux/amd64/doom.x86 || die "doexe amd64 exes"
		fi
	else
		die "Cannot copy executables!"
	fi

	doins -r base d3xp pb || die "doins base d3xp pb"

	games_make_wrapper doom3 ./doom.x86 "${dir}" "${dir}"
	if use dedicated; then
		games_make_wrapper doom3-ded ./doomded.x86 "${dir}" "${dir}"
	fi

	doicon "${DISTDIR}"/doom3.png || die "Copying icon"

	prepgamesdirs
	make_desktop_entry doom3 "Doom III" doom3
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall; then
		elog "You need to copy pak000.pk4, pak001.pk4, pak002.pk4, pak003.pk4, and"
		elog "pak004.pk4 from either your installation media or your hard drive to"
		elog "${dir}/base before running the game,"
		elog "or 'emerge games-fps/doom3-data' to install from CD."
		echo
		if ! use roe
		then
			elog "To use the Resurrection of Evil expansion pack, you also need to copy"
			elog "pak000.pk4 to ${dir}/d3xp from the RoE CD before running the game,"
			elog "or 'emerge doom3-roe' to install from CD."
		fi
	fi
	echo
	elog "To play the game run:"
	elog " doom3"
	echo
}
