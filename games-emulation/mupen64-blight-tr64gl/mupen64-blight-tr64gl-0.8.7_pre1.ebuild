# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-blight-tr64gl/mupen64-blight-tr64gl-0.8.7_pre1.ebuild,v 1.1 2005/01/23 02:15:23 morfic Exp $

inherit games

MY_P="tr64gl-0.8.7-pre1"
DESCRIPTION="An OpenGL graphics plugin for the mupen64 N64 emulator"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"
SRC_URI="mirror://gentoo/${MY_P}.so"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/libsdl"

S="${WORKDIR}"

src_install () {
	exeinto "${GAMES_LIBDIR}/mupen64/plugins"
	doexe ${MY_P}.so || die "doexe failed"
	prepgamesdirs
}
