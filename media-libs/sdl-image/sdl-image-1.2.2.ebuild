# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-image/sdl-image-1.2.2.ebuild,v 1.9 2003/04/25 14:13:09 vapier Exp $

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="image file loading library"
SRC_URI="http://www.libsdl.org/projects/SDL_image/release/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/SDL_image/index.html"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND=">=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b
	>=media-libs/libsdl-1.2"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
