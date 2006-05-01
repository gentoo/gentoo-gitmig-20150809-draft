# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-bin/quake4-bin-1.2.1.ebuild,v 1.1 2006/05/01 15:51:45 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Sequel to Quake 2, an Id 3D first-person shooter"
HOMEPAGE="http://www.quake4game.com/"
SRC_URI="mirror://idsoftware/quake4/linux/quake4-linux-${PV}.x86.run"

LICENSE="QUAKE4"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="alsa cdinstall dedicated opengl"
RESTRICT="strip"

UIDEPEND="virtual/opengl
	x86? (
		|| (
			(
				x11-libs/libXext
				x11-libs/libX11
				x11-libs/libXau
				x11-libs/libXdmcp )
			virtual/x11 ) )
		media-libs/libsdl
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=media-video/nvidia-glx-1.0.6629-r3
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )
	alsa? ( >=media-libs/alsa-lib-1.0.6 )"

RDEPEND="sys-libs/glibc
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	opengl? ( ${UIDEPEND} )
	cdinstall? ( games-fps/quake4-data )
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/quake4
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself quake4-linux-${PV}.x86.run
}

src_install() {
	insinto "${dir}"
	exeinto "${dir}"

	doins *.txt README q4icon.bmp us/version.info README-1.2.htm
	doins -r pb
	doexe openurl.sh || die "openurl.sh"
	doexe bin/Linux/x86/quake4.x86 bin/Linux/x86/q4ded.x86 \
		bin/Linux/x86/libgcc_s.so.1 bin/Linux/x86/libstdc++.so.* \
		|| die "doexe x86 exes/libs"
	newexe bin/Linux/x86/libSDL-1.2.id.so.0 libSDL-1.2.so.0 || die "libSDL"

	insinto ${dir}/q4base
	doins q4base/* us/q4base/* || die "doins q4base"
	if use dedicated
	then
		games_make_wrapper quake4-ded ./q4ded.x86 "${dir}" "${dir}"
	fi

	if use opengl || ! use dedicated
	then
		games_make_wrapper quake4 ./quake4.x86 "${dir}" "${dir}"
		games_make_wrapper quake4-smp ./quake4smp.x86 "${dir}" "${dir}"
#		doicon ${FILESDIR}/quake4.png || die "copying icon"
#		make_desktop_entry quake4 "Quake IV" quake4.png
		newicon q4icon.bmp quake4.bmp || die "copying icon"
		make_desktop_entry quake4 "Quake IV" /usr/share/pixmaps/quake4.bmp
		make_desktop_entry quake4-smp "Quake IV (SMP)" /usr/share/pixmaps/quake4.bmp
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall
	then
		einfo "You need to copy pak001.pk4 through pak012.pk4, along with"
		einfo "zpak*.pk4 from either your installation media or your hard drive"
		einfo "to ${dir}/q4base before running the game."
		echo
	fi
	if use opengl || ! use dedicated
	then
		einfo "To play the game run:"
		einfo " quake4"
		echo
	fi
}
