# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fbzx/fbzx-2.1b.ebuild,v 1.1 2009/04/30 03:39:11 mr_bones_ Exp $

EAPI=2
inherit eutils toolchain-funcs games

DESCRIPTION="A Sinclair Spectrum emulator, designed to work at full screen using the FrameBuffer"
HOMEPAGE="http://www.rastersoft.com/fbzx.html"
SRC_URI="http://www.rastersoft.com/descargas/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/alsa-lib"

src_prepare() {
	sed -i \
		-e "s|/usr/share/|${GAMES_DATADIR}/${PN}/|g" \
		emulator.c || die "sed failed"
	sed -i \
		-e "/^CC/s:gcc:$(tc-getCC):" \
		-e "s/^\(CC =\).*/\1 $(tc-getCC) ${CFLAGS} \$(SDL_CFLAGS)/" \
		-e "s:-O2:${CFLAGS}:" \
		Makefile || die "sed failed"
	sed -i \
		-e "/^Version/s|2.1|1.0|" \
		-e "/^Encoding/d" \
		fbzx.desktop || die "sed failed"
	rm -f fbzx_fs fbzx *.o # clean out accidentally packaged .o files
}

src_install() {
	dogamesbin fbzx || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r keymap.bmp spectrum-roms || die "doins failed"
	dodoc AMSTRAD CAPABILITIES FAQ PORTING README* TODO VERSIONS
	domenu fbzx.desktop
	doicon fbzx.svg
	prepgamesdirs
}
