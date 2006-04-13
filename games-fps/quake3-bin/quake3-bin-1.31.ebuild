# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-bin/quake3-bin-1.31.ebuild,v 1.8 2006/04/13 21:09:21 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="mirror://idsoftware/quake3/linux/linuxq3apoint-${PV}.x86.run"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="dedicated opengl"
RESTRICT="strip"

RDEPEND="sys-libs/glibc
	opengl? (
		virtual/opengl
		x86? (
			|| (
				(
					x11-libs/libXext
					x11-libs/libX11
					x11-libs/libXau
					x11-libs/libXdmcp )
				virtual/x11 ) ) )
	dedicated? (
		app-misc/screen )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		opengl? (
			app-emulation/emul-linux-x86-xlibs
			|| ( >=media-video/nvidia-glx-1.0.6629-r3
			>=x11-drivers/ati-drivers-8.8.25-r1 ) ) )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/quake3
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself
}

src_install() {
	insinto ${dir}/baseq3
	doins baseq3/*.pk3
	mv Help ${Ddir}
	insinto ${dir}/missionpack
	doins missionpack/*.pk3

	exeinto ${dir}
	insinto ${dir}
	doexe bin/x86/{quake3.x86,q3ded} || die "doexe"
	doins quake3.xpm README* Q3A_EULA.txt
	games_make_wrapper quake3-bin ./quake3.x86 "${dir}" "${dir}"
	games_make_wrapper q3ded-bin ./q3ded "${dir}" "${dir}"

	newinitd "${FILESDIR}"/q3ded.rc q3ded
	newconfd "${FILESDIR}"/q3ded.conf.d q3ded
	doicon quake3.xpm

	prepgamesdirs
	make_desktop_entry quake3-bin "Quake III Arena (binary)" quake3.xpm
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "There are two possible security bugs in this package, both causing a	denial"
	ewarn "of service.  One affects the game when running a server, the other when running"
	ewarn "as a client.  For more information, see bug #82149."
	echo
	einfo "You need to copy pak0.pk3 from your Quake3 CD into ${dir}/baseq3."
	einfo "Or if you have got a Window installation of Q3 make a symlink to save space."
	echo
	if use dedicated; then
		einfo "To start a dedicated server, run"
		einfo "\t/etc/init.d/q3ded start"
		echo
		einfo "The dedicated server is started under the ${GAMES_USER_DED} user account."
	fi
}
