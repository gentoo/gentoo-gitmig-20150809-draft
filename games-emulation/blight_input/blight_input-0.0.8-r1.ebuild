# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/blight_input/blight_input-0.0.8-r1.ebuild,v 1.1 2004/03/30 12:03:06 mr_bones_ Exp $

inherit games

S="${WORKDIR}/blight_input-0.0.8-b"
DESCRIPTION="An input plugin for the mupen64 N64 emulator"
HOMEPAGE="http://mupen64.emulation64.com/"
SRC_URI="http://deltaanime.ath.cx/~blight/n64/blight_input_plugin/${P}-b.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	media-libs/sdl-ttf
	media-libs/freetype"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Death to all who distribute their stinking config.cache files!
	rm -f config.cache
}

src_install() {
	make install						|| die "make install failed"
	exeinto ${GAMES_LIBDIR}/mupen64/plugins
	doexe src/blight_input.so			|| die "doexe failed"
	dodoc AUTHORS ChangeLog README ToDo || die "dodoc failed"
}
