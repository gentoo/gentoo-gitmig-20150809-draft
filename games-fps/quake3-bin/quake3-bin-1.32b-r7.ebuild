# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-bin/quake3-bin-1.32b-r7.ebuild,v 1.4 2006/05/01 17:38:58 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="mirror://idsoftware/quake3/linux/linuxq3apoint-${PV}-3.x86.run"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="cdinstall dedicated opengl teamarena"
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
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=media-video/nvidia-glx-1.0.6629-r3
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )"

RDEPEND="sys-libs/glibc
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	opengl? ( ${UIDEPEND} )
	cdinstall? ( games-fps/quake3-data )
	cdinstall? ( teamarena? ( games-fps/quake3-teamarena ) )
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/quake3
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	if use cdinstall
	then
		built_with_use games-fps/quake3-data cdinstall \
			|| die "You must install quake3-data with USE=cdinstall to get the required data."
	fi
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir ${dir}/{baseq3,missionpack}
	if use cdinstall ; then
		dosym ${GAMES_DATADIR}/quake3/baseq3/pak0.pk3 ${dir}/baseq3/pak0.pk3
		use teamarena && dosym ${GAMES_DATADIR}/quake3/missionpack/pak0.pk3 \
			${dir}/missionpack/pak0.pk3
	fi
	for pk3 in baseq3/*.pk3 missionpack/*.pk3 ; do
		dosym ${GAMES_DATADIR}/quake3/${pk3} ${dir}/${pk3}
	done

	insinto ${dir}
	doins -r Docs pb || die "ins docs/pb"

	exeinto ${dir}
	insinto ${dir}
	doexe bin/Linux/x86/quake3.x86 || die "doexe"
	doins quake3.xpm README* Q3A_EULA.txt
	if use opengl || ! use dedicated
	then
		games_make_wrapper ${PN} ./quake3.x86 "${dir}" "${dir}"
		newicon quake3.xpm ${PN}.xpm
		make_desktop_entry ${PN} "Quake III Arena (binary)" ${PN}.xpm
		if use teamarena
		then
			games_make_wrapper ${PN}-teamarena \
				"./quake3.x86 +set fs_game missionpack" "${dir}" "${dir}"
			make_desktop_entry ${PN}-teamarena \
				"Quake III Team Arena (binary)" quake3-bin.xpm
		fi
	fi
	if use dedicated
	then
		doexe bin/Linux/x86/q3ded || die "doexe q3ded"
		games_make_wrapper q3ded-bin ./q3ded "${dir}" "${dir}"
		newinitd "${FILESDIR}"/q3ded.rc q3ded
		newconfd "${FILESDIR}"/q3ded.conf.d q3ded
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "There are two possible security bugs in this package, both causing a"
	ewarn "denial of service. One affects the game when running a server, the"
	ewarn "other when running as a client."
	ewarn "For more information, please see bug #82149."
	if use dedicated; then
		echo
		einfo "To start a dedicated server, run"
		einfo "  /etc/init.d/q3ded start"
		echo
		einfo "The dedicated server is started under the ${GAMES_USER_DED} user account."
	fi

	# IA32 Emulation required for amd64
	if use amd64 ; then
		echo
		ewarn "NOTE: IA32 Emulation must be compiled into your kernel for Quake3 to run."
	fi
}
