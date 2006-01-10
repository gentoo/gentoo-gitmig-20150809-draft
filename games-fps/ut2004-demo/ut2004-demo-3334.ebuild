# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-demo/ut2004-demo-3334.ebuild,v 1.10 2006/01/10 16:01:51 wolf31o2 Exp $

inherit eutils games

MY_P="ut2004-lnx-demo${PV}.run"
DESCRIPTION="Unreal Tournament 2004 Demo"
HOMEPAGE="http://www.unrealtournament.com/"

SRC_URI="mirror://3dgamers/unrealtourn2k4/${MY_P}"

IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86 amd64"

DEPEND=""
RDEPEND="virtual/opengl
	=virtual/libstdc++-3.3
	x86? (
		|| (
			(
				x11-libs/libX11
				x11-libs/libXext )
			virtual/x11 ) )
	amd64? (
		app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself
	tar zxf setupstuff.tar.gz || die "unpacking setupstuff"
}

src_install() {
	dodir ${dir}

	tar xjf ut2004demo.tar.bz2 -C ${Ddir} || die "unpacking ut2004 failed"

	if use x86
	then
		tar xjf linux-x86.tar.bz2 || die "unpacking exe"
	fi
	if use amd64
	then
		tar xjf linux-amd64.tar.bz2 || die "unpacking exe"
	fi

	insinto ${dir}
	doins README.linux ut2004.xpm
	newicon ut2004.xpm ut2004-demo.xpm

	exeinto ${dir}
	doexe bin/ut2004-demo

	exeinto ${dir}/System
	doexe System/{libSDL-1.2.so.0,openal.so,ucc-bin,ut2004-bin}

	dodir
	games_make_wrapper ut2004-demo ./ut2004-demo "${dir}" "${dir}"

	prepgamesdirs
	make_desktop_entry ut2004-demo "UT2004 Demo" ut2004-demo.xpm
}

pkg_postinst() {
	einfo
	einfo "For Text To Speech:"
	einfo "   1) emerge festival speechd"
	einfo "   2) Edit your ~/.ut2004demo/System/UT2004.ini file."
	einfo "      In the [SDLDrv.SDLClient] section, add:"
	einfo "         TextToSpeechFile=/dev/speech"
	einfo "   3) Start speechd."
	einfo "   4) Start the game.  Be sure to go into the Audio"
	einfo "      options and enable Text To Speech."
	einfo
	einfo "To test, pull down the console (~) and type:"
	einfo "   TTS this is a test."
	einfo
	einfo "You should hear something that sounds like 'This is a test.'"
	einfo
	games_pkg_postinst
}
