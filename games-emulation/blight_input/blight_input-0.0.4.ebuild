# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/blight_input/blight_input-0.0.4.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

DESCRIPTION="An input plugin for the mupen64 N64 emulator"
SRC_URI="http://deltaanime.ath.cx/~blight/n64/blight_input_plugin/${P}.tar.gz"
HOMEPAGE="http://mupen64.emulation64.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc"

DEPEND="media-libs/libsdl
	media-libs/freetype"

src_compile() {
	cd ${S}/SDL_ttf2
	rm config.cache
	cp SDL_ttf.h ${S}
	econf || die
	emake || die "emake failed in ${S}/SDL_ttf2"
	cd ${S}
	emake || die "emake failed in ${S}"
}

src_install() {
	dodir /usr/lib/mupen64/plugins
	insinto /usr/lib/mupen64/plugins
	doins blight_input.so
}
