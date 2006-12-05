# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/rtcwsp-demo/rtcwsp-demo-1.1b.ebuild,v 1.7 2006/12/05 17:59:02 wolf31o2 Exp $

inherit eutils games

MY_P="wolfspdemo-linux-${PV}.x86.run"

DESCRIPTION="Return to Castle Wolfenstein - Single-player demo"
HOMEPAGE="http://games.activision.com/games/wolfenstein/"
SRC_URI="mirror://idsoftware/wolf/linux/old/${MY_P}
	mirror://3dgamers/returnwolfenstein/${MY_P}"

LICENSE="RTCW"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip mirror"

RDEPEND="sys-libs/glibc
	virtual/opengl
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXau
		x11-libs/libXdmcp )
	amd64? (
		app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself ${A} || die "Unpacking files"
}

src_install() {
	insinto "${dir}"
	doins -r demomain Docs

	exeinto "${dir}"
	doexe bin/x86/wolfsp.x86 openurl.sh || die "copying exe"

	games_make_wrapper ${PN} ./wolfsp.x86 "${dir}" "${dir}"

	doins WolfSP.xpm CHANGES
	newicon WolfSP.xpm ${PN}.xpm

	prepgamesdirs
	make_desktop_entry ${PN} "Return to Castle Wolfenstein (SP demo)" \
		${PN}.xpm
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Install 'rtcwmp-demo' for multi-player"
	echo
	einfo "Run '${PN}' for single-player"
}
