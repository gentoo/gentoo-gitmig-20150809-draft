# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory/enemy-territory-2.60.ebuild,v 1.1 2005/03/22 17:48:03 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Return to Castle Wolfenstein: Enemy Territory - standalone multi-player game based on Return to Castle Wolfenstein"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="mirror://3dgamers/pub/3dgamers4/games/wolfensteinet/et-linux-${PV}.x86.run
	mirror://3dgamers/pub/3dgamers/games/wolfensteinet/et-linux-${PV}.x86.run"

LICENSE="RTCW-ETEULA"
SLOT="0"
# This game is actively maintained by a developer with both x86 and amd64 kit.
# DO NOT TOUCH THIS EBUILD WITHOUT THE PERMISSION OF wolf31o2!!!
KEYWORDS="~x86 ~amd64"
IUSE="dedicated opengl"
RESTRICT="nomirror nostrip"

DEPEND="virtual/libc"
RDEPEND="dedicated? ( app-misc/screen )
	!dedicated? ( virtual/opengl )
	opengl? ( virtual/opengl )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0-r1 )"

S="${WORKDIR}"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

pkg_setup() {
	check_license || die "License check failed"
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	exeinto ${dir}
	doexe bin/Linux/x86/et.x86 openurl.sh || die "doexe failed"
	insinto ${dir}
	dodoc CHANGES README || die "doins failed"
	doicon ET.xpm

	cp -r Docs pb etmain "${Ddir}" || die "cp failed"

	games_make_wrapper et ./et.x86 ${dir}

	if use dedicated ; then
		doexe bin/Linux/x86/etded.x86 || die "doexe failed"
		games_make_wrapper et-ded ./etded.x86 ${dir}
		newinitd ${FILESDIR}/et-ded.rc et-ded || die "newinitd failed"
		dosed "s:GAMES_USER_DED:${GAMES_USER_DED}:" /etc/init.d/et-ded
		dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/et-ded
		newconfd ${FILESDIR}/et-ded.conf.d et-ded || die "newconfd failed"
	fi

	# TODO: move this to /var/ perhaps ?
	dodir "${dir}/etwolf-homedir"
	dosym "${dir}/etwolf-homedir" "${GAMES_PREFIX}/.etwolf"

	prepgamesdirs
	make_desktop_entry et "Enemy Territory" ET.xpm
	chmod g+rw "${Ddir}" "${Ddir}/etwolf-homedir" "${Ddir}/etmain"
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "To play the game run:"
	einfo " et"

	if use dedicated; then
		echo
		einfo "To start a dedicated server run:"
		einfo " /etc/init.d/et-ded start"
		echo
		einfo "To run the dedicated server at boot, type:"
		einfo " rc-update add et-ded default"
		echo
		einfo "The dedicated server is started under the ${GAMES_USER_DED} user account"
	fi
	if use amd64; then
		echo
		einfo "If you are running an amd64 system and using ALSA, you must have"
		einfo "ALSA 32-bit emulation enabled in your kernel for this to function properly."
	fi
}
