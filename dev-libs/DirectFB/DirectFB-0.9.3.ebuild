# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.3.ebuild,v 1.1 2001/06/21 17:46:41 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux fb devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${A}"
HOMEPAGE="http://www.directfb.org"

DEPEND="virtual/glibc sys-devel/perl >=media-libs/freetype-2.0.1 >=media-libs/jpeg-6
	>=media-libs/libpng-1.0.10 >=media-libs/libflash-0.4.10
	avifile? ( >=media-video/avifile-0.6.0 )
	libmpeg3? ( >=media-libs/libmpeg3-1.2.3 )"

RDEPEND="virtual/glibc >=media-libs/freetype-2.0.1 >=media-libs/jpeg-6
	>=media-libs/libpng-1.0.10 >=media-libs/libflash-0.4.10
	avifile? ( >=media-video/avifile-0.6.0 )
	libmpeg3? ( >=media-libs/libmpeg3-1.2.3 )"

src_compile() {
    if [ "`use mmx`" ] ; then
      myconf="--enable-mmx"
    else
      myconf="--disable-mmx"
    fi
    if [ "`use avifile`" ] ; then
      myconf="$myconf --enable-avifile"
    else
      myconf="$myconf --disable-avifile"
    fi
    if [ "`use libmpeg3`" ] ; then
      myconf="$myconf --with-libmpeg3=/usr/include/libmpeg3"
      mkdir ${S}/interfaces/IDirectFBVideoProvider/no
      cp /usr/lib/libmpeg3.a ${S}/interfaces/IDirectFBVideoProvider/no
    else
      myconf="$myconf --without-libmpeg3"
    fi
    if [ "$DEBUG" ] ; then
      myconf="$myconf --enable-debug"
    else
      myconf="$myconf --disable-debug"
    fi
    try ./configure --prefix=/usr --host=${CHOST} $myconf \
	--enable-jpeg --enable-png --enable-gif 
#    cp Makefile Makefile.orig
#    sed -e "s:examples::" Makefile.orig > Makefile
    if [ "`use libmpeg3`" ] ; then
       try make LIBMPEG3_DIR=/usr/lib LIBMPEG3_LIBS=-lmpeg3
    else
    try make
    fi

}

src_install () {
    if [ "`use libmpeg3`" ] ; then
       try make LIBMPEG3_DIR=/usr/lib LIBMPEG3_LIBS=-lmpeg3 DESTDIR=${D} install
    else
    try make DESTDIR=${D} install
    fi
    dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
    docinto html
    dodoc docs/html/*.{png,html}
}

