# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory/enemy-territory-2.60.ebuild,v 1.16 2006/04/13 20:41:59 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="standalone multi-player game based on Return to Castle Wolfenstein"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="mirror://3dgamers/wolfensteinet/et-linux-${PV}.x86.run
	mirror://idsoftware/et/linux/et-linux-${PV}.x86.run
	ftp://ftp.red.telefonica-wholesale.net/GAMES/ET/linux/et-linux-${PV}.x86.run
	dedicated? (
		http://dev.gentoo.org/~wolf31o2/sources/dump/${PN}-all-0.1.tar.bz2
		mirror://gentoo/${PN}-all-0.1.tar.bz2 )"

LICENSE="RTCW-ETEULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"
RESTRICT="mirror strip"

DEPEND="sys-libs/glibc"
RDEPEND="dedicated? ( app-misc/screen )
	!dedicated? ( virtual/opengl )
	opengl? ( virtual/opengl )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0-r1 )"

S="${WORKDIR}"

GAMES_CHECK_LICENSE="yes"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

src_unpack() {
	unpack_makeself et-linux-${PV}.x86.run
	if use dedicated; then
		unpack ${PN}-all-0.1.tar.bz2 || die
	fi
}

src_install() {
	exeinto ${dir}
	doexe bin/Linux/x86/et.x86 openurl.sh || die "doexe failed"
	insinto ${dir}
	dodoc CHANGES README || die "doins failed"
	doicon ET.xpm

	cp -r Docs pb etmain "${Ddir}" || die "cp failed"

	games_make_wrapper et ./et.x86 "${dir}" "${dir}"

	if use dedicated ; then
		doexe bin/Linux/x86/etded.x86 || die "doexe failed"
		games_make_wrapper et-ded ./etded.x86 ${dir}
		newinitd ${S}/et-ded.rc et-ded || die "newinitd failed"
		dosed "s:GAMES_USER_DED:${GAMES_USER_DED}:" /etc/init.d/et-ded
		dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/et-ded
		newconfd ${S}/et-ded.conf.d et-ded || die "newconfd failed"
	fi

	# TODO: move this to /var/ perhaps ?
	dodir "${dir}/etwolf-homedir"
	dosym "${dir}/etwolf-homedir" "${GAMES_PREFIX}/.etwolf"

	make_desktop_entry et "Enemy Territory" ET.xpm

	prepgamesdirs
	chmod g+rw "${Ddir}" "${Ddir}/etwolf-homedir" "${Ddir}/etmain"
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "There are two possible security bugs in this package, both causing a"
	ewarn "denial of service.  One affects the game when running a server, the"
	ewarn "other when running as a client.  For more information, see"
	ewarn "bug #82149."
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
