# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-blight-input/mupen64-blight-input-0.0.8-r1.ebuild,v 1.1 2005/01/06 02:51:04 morfic Exp $

inherit games

DESCRIPTION="An input plugin for the mupen64 N64 emulator"
HOMEPAGE="http://mupen64.emulation64.com/"
SRC_URI="http://deltaanime.ath.cx/~blight/n64/blight_input_plugin/blight_input-0.0.8-b.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	media-libs/sdl-ttf
	media-libs/freetype"

S="${WORKDIR}/blight_input-0.0.8-b"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Death to all who distribute their stinking config.cache files!
	rm -f config.cache
}

src_install() {
	make install || die "make install failed"
	exeinto "${GAMES_LIBDIR}/mupen64/plugins"
	doexe src/blight_input.so || die "doexe failed"
	dodoc AUTHORS ChangeLog README ToDo
	prepgamesdirs
}
