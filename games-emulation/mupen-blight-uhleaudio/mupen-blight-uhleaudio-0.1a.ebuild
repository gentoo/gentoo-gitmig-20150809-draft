# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen-blight-uhleaudio/mupen-blight-uhleaudio-0.1a.ebuild,v 1.1 2005/01/06 02:37:24 morfic Exp $

inherit games

MY_P="uhleaudio-${PV}"
DESCRIPTION="An audio plugin for the mupen64 N64 emulator"
SRC_URI="http://deltaanime.ath.cx/~blight/n64/uhleaudio_plugin/${MY_P}.so"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"

KEYWORDS="x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND="media-libs/libsdl"

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR} || die "cp failed"
}

src_install () {
	exeinto ${GAMES_LIBDIR}/mupen64/plugins
	doexe ${WORKDIR}/${MY_P}.so || die "doexe failed"
	prepgamesdirs
}
