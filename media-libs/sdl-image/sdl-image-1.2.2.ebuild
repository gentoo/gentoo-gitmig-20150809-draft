# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-image/sdl-image-1.2.2.ebuild,v 1.1 2002/05/06 14:44:08 seemant Exp $

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="SDL-image is an image file loading library"
SRC_URI="http://www.libsdl.org/projects/SDL_image/release/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/SDL_image/index.html"

DEPEND="virtual/glibc
	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b
        >=media-libs/libsdl-1.2"


src_compile() {

	./configure --infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST} || die
		
	emake || die
}

src_install() {

	# emake prefix=${D}/usr install
	make DESTDIR=${D} install
}

