# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>

S=${WORKDIR}/${P}
DESCRIPTION="An image viewer that uses OpenGL"
SRC_URI="http://gliv.tuxfamily.org/gliv-${PV}.tar.bz2"
HOMEPAGE="http://gliv.tuxfamily.org"

DEPEND="x11-libs/gtk+
	media-libs/gdk-pixbuf
	x11-libs/gtkglarea
	virtual/opengl"

src_compile() {

	./configure --prefix=/usr				\
		    --mandir=/usr/share/man			\
		    --host=${CHOST} || die
	
	make || die
}

src_install () {

    make prefix=${D}/usr					\
         mandir=${D}/usr/share/man				\
	 install || die
    
    dodoc COPYING README NEWS THANKS
}

