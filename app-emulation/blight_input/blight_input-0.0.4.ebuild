# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/blight_input/blight_input-0.0.4.ebuild,v 1.4 2003/06/12 19:53:47 msterret Exp $

S=${WORKDIR}/${P}
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
	emake || die
cd ${S}
	emake || die
}

src_install () {
	dodir /usr/lib/mupen64/plugins
	insinto /usr/lib/mupen64/plugins
        doins blight_input.so
}
