# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Creswick <davidc@sat.net>
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-ttf/sdl-ttf-2.0.4.ebuild,v 1.1 2001/12/19 20:56:54 azarah Exp $

MY_P="${P/sdl-/SDL_}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"
SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"

DEPEND=">=media-libs/libsdl-1.2.3
	>=media-libs/freetype-2.0.1"


src_compile() {

	./configure --infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST} || die
		
	emake || die
}

src_install() {

	make prefix=${D}/usr install || die

	dodoc CHANGES COPYING README
}
