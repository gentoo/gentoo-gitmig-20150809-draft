# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-image/sdl-image-1.2.0.ebuild,v 1.1 2001/08/12 13:26:02 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="SDL-image is an image file loading library"

SRC_URI="http://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.0.tar.gz"

HOMEPAGE="http://www.libsdl.org/projects/SDL_image/index.html"

#build-time dependencies
DEPEND="virtual/glibc
	>=media-libs/libpng-1.0
	>=media-libs/jpeg-6b
        >=media-libs/libsdl-1.2"

src_unpack() {
	cd ${WORKDIR}
	unpack SDL_image-1.2.0.tar.gz
	mv SDL_image-1.2.0 ${P}
}

src_compile() {

	try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
	try emake
}

src_install () {
	# try make prefix=${D}/usr install
    try make DESTDIR=${D} install
}

