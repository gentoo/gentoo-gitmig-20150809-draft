# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-demo/ut2004-demo-3120-r3.ebuild,v 1.1 2004/03/03 16:40:07 wolf31o2 Exp $

inherit games eutils

DESCRIPTION="Unreal Tournament 2004 Demo"
HOMEPAGE="http://www.unrealtournament.com/"

SRC_URI="x86? ( ftp://ftp.linuxhardware.org/ut2004/ut2004-lnx-demo-${PV}.run.bz2
	http://www.lokigames.com/sekrit/ut2004-lnx-demo-${PV}.run.bz2
	http://pomac.netswarm.net/mirror/games/ut2004/ut2004-lnx-demo-${PV}.run.bz2
	http://icculus.org/~icculus/tmp/${PN}-lnx-tts-pingpatch.tar.bz2
	http://icculus.org/~icculus/tmp/please_test_with_ut2004-2.tar.bz2 )
	amd64? ( mirror://gentoo/ut2004-lnx64-demo-${PV}.run.bz2
	http://icculus.org/~icculus/tmp/${PN}-lnx64-tts-pingpatch.tar.bz2 )"

IUSE="alsa"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"

DEPEND="!dedicated? ( virtual/opengl )
	alsa? ( >=media-libs/alsa-lib-1.0.2 ) "

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	[ "${ARCH}" = "amd64" ] && RNAME="ut2004-lnx64-demo-${PV}.run"
	[ "${ARCH}" = "x86" ] && RNAME="ut2004-lnx-demo-${PV}.run"
	unpack_makeself ${RNAME}
	rm ${RNAME}
	# We unpack this one again so the right files are in the right places
	unpack ${DISTDIR}/please_test_with_ut2004-2.tar.bz2
}

src_install() {
	local dir=/opt/${PN}
	dodir ${dir}

	tar -xf ut2004demo.tar -C ${D}/${dir}/ || die "unpacking ut2004 failed"

	insinto ${dir}
	doins README.linux ut2004demo.xpm

	exeinto ${dir}
	doexe bin/ut2004demo

	dodir ${GAMES_BINDIR}
	dosym ${dir}/ut2004demo ${GAMES_BINDIR}/ut2004demo

	# Ping patch
	exeinto ${dir}/System
	doexe ut2004-bin
	doins README-tts.txt tts-festival.pl

	# ALSA and VoIP
	if [ "`use alsa`" && "`use amd64`" ]; then
		rm ${D}/${dir}/System/{libSDL-1.2.so.0,openal.so} || die "removing libs"
		dosym /usr/lib/libSDL-1.2.so.0 ${dir}/System/libSDL-1.2.so.0 || die "SDL symlink"
		dosym /usr/lib/libopenal.so.0 ${dir}/System/openal.so || die "OpenAL symlink"
	fi

	prepgamesdirs
}

pkg_postinst() {
	einfo ""
	einfo "For Text To Speech:"
	einfo "   1) emerge festival speech"
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
