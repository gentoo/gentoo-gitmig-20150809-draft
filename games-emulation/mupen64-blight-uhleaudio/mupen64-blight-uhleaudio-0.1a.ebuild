# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-blight-uhleaudio/mupen64-blight-uhleaudio-0.1a.ebuild,v 1.2 2007/04/09 15:44:12 nyhm Exp $

inherit games

MY_P="uhleaudio-${PV}"
DESCRIPTION="An audio plugin for the mupen64 N64 emulator"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"
SRC_URI="http://deltaanime.ath.cx/~blight/n64/uhleaudio_plugin/${MY_P}.so"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="media-libs/libsdl"

src_install() {
	exeinto "$(games_get_libdir)"/mupen64/plugins
	doexe "${DISTDIR}"/${MY_P}.so || die "doexe failed"
	prepgamesdirs
}
