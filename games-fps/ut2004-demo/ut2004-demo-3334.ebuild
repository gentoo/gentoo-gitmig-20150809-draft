# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-demo/ut2004-demo-3334.ebuild,v 1.3 2004/11/17 19:01:37 wolf31o2 Exp $

inherit games eutils

MY_P="ut2004-lnx-demo${PV}.run"
DESCRIPTION="Unreal Tournament 2004 Demo"
HOMEPAGE="http://www.unrealtournament.com/"

SRC_URI="mirror://3dgamers/pub/3dgamers6/games/unrealtourn2k4/${MY_P}
	mirror://3dgamers/pub/3dgamers/games/unrealtourn2k4/${MY_P}"

IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86 amd64"

DEPEND="virtual/opengl"

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

	use x86 && tar xjf linux-x86.tar.bz2 #|| die "unpacking exe"
	use amd64 && tar xjf linux-amd64.tar.bz2 #|| die "unpacking exe"

	insinto ${dir}
	doins README.linux ut2004.xpm
	insinto /usr/share/pixmaps
	newins ut2004.xpm ut2004-demo.xpm

	exeinto ${dir}
	doexe bin/ut2004-demo

	exeinto ${dir}/System
	doexe System/{libSDL-1.2.so.0,openal.so,ucc-bin,ut2004-bin}

	dodir
	games_make_wrapper ut2004-demo ./ut2004-demo ${dir}

	prepgamesdirs
	make_desktop_entry ut2004-demo "UT2004 Demo" ut2004-demo.xpm
}

pkg_postinst() {
	einfo ""
	einfo "For Text To Speech:"
	einfo "   1) emerge festival speechd"
	einfo "   2) Edit your ~/.ut2004demo/System/UT2004.ini file."
	einfo "      In the [SDLDrv.SDLClient] section, add:"
	einfo "         TextToSpeechFile=/dev/speech"
	einfo "   3) Start speechd."
	einfo "   4) Start the game.  Be sure to go into the Audio"
	einfo "      options and enable Text To Speech."
	einfo ""
	einfo "To test, pull down the console (~) and type:"
	einfo "   TTS this is a test."
	einfo ""
	einfo "You should hear something that sounds like 'This is a test.'"
	einfo ""
	games_pkg_postinst
}
