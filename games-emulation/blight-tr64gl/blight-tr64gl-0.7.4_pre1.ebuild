# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/blight-tr64gl/blight-tr64gl-0.7.4_pre1.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games

S=${WORKDIR}
MY_P="blight_tr64gl-0.7.4-pre1"
DESCRIPTION="An OpenGL graphics plugin for the mupen64 N64 emulator"
SRC_URI="http://deltaanime.ath.cx/~blight/n64/blight_tr64gl_port/${MY_P}.so.gz"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"

KEYWORDS="x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
}

src_install () {
	exeinto ${GAMES_LIBDIR}/mupen64/plugins
	doexe ${MY_P}.so || die "doexe failed"
	prepgamesdirs
}
