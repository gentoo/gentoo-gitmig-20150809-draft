# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/rtcw/rtcw-1.41-r2.ebuild,v 1.6 2005/06/15 18:40:04 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Return to Castle Wolfenstein - Long awaited sequel to Wolfenstein 3D"
HOMEPAGE="http://games.activision.com/games/wolfenstein/"
SRC_URI="mirror://3dgamers/pub/3dgamers/games/returnwolfenstein/Missions/wolf-linux-goty-maps.x86.run
	mirror://3dgamers/pub/3dgamers/games/returnwolfenstein/wolf-linux-${PV}-3.x86.run"

LICENSE="RTCW"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="opengl dedicated"
RESTRICT="nostrip nomirror"

DEPEND="virtual/libc"
RDEPEND="dedicated? ( app-misc/screen )
	!dedicated? ( virtual/opengl )
	opengl? ( virtual/opengl )
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"
	games_pkg_setup
}

src_unpack() {
	unpack_makeself wolf-linux-goty-maps.x86.run
	unpack_makeself wolf-linux-${PV}-3.x86.run
}

src_install() {
	dodir ${dir}

	cp -r main Docs pb ${Ddir}

	exeinto ${dir}
	doexe bin/Linux/x86/*.x86 openurl.sh

	games_make_wrapper wolfmp ./wolf.x86 ${dir}
	games_make_wrapper wolfsp ./wolfsp.x86 ${dir}

	if use dedicated; then
		games_make_wrapper wolf-ded ./wolfded.x86 ${dir}
		exeinto /etc/init.d
		newexe ${FILESDIR}/wolf-ded.rc wolf-ded
		dosed "s:GENTOO_DIR:${dir}:" /etc/init.d/wolf-ded
	fi

	insinto ${dir}
	doins WolfMP.xpm WolfSP.xpm QUICKSTART CHANGES RTCW-README-1.4.txt
	doicon WolfMP.xpm WolfSP.xpm

	prepgamesdirs
	make_desktop_entry wolfmp "Return to Castle Wolfenstein (MP)" WolfMP.xpm
	make_desktop_entry wolfsp "Return to Castle Wolfenstein (SP)" WolfSP.xpm
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "There are two possible security bugs in this package, both causing a denial"
	ewarn "of service.  One affects the game when running a server, the other when running"
	ewarn "as a client.  For more information, see bug #82149."
	echo
	einfo "You need to copy pak0.pk3, mp_pak0.pk3, mp_pak1.pk3, mp_pak2.pk3,"
	einfo "sp_pak1.pk3 and sp_pak2.pk3 from a Window installation into ${dir}/main/"
	echo
	einfo "To play the game run:"
	einfo " wolfsp (single-player)"
	einfo " wolfmp (multi-player)"
	if use dedicated
	then
		echo
		einfo "To start a dedicated server run:"
		einfo " /etc/init.d/wolf-ded start"
		echo
		einfo "To run the dedicated server at boot, type:"
		einfo " rc-update add wolf-ded default"
		echo
		einfo "The dedicated server is started under the ${GAMES_USER_DED} user account"
	fi
}
