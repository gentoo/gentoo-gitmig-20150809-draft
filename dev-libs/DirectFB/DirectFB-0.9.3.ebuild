# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.3.ebuild,v 1.3 2001/11/10 12:05:20 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux fb devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"
HOMEPAGE="http://www.directfb.org"

RDEPEND="virtual/glibc
	>=media-libs/freetype-2.0.1
	>=media-libs/jpeg-6
	>=media-libs/libpng-1.0.10
	>=media-libs/libflash-0.4.10
	avifile? ( >=media-video/avifile-0.6.0 )
	libmpeg3? ( >=media-libs/libmpeg3-1.2.3 )"

DEPEND="${RDEPEND}
	sys-devel/perl"

src_compile() {
	local myconf

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
		myconf="$myconf --disable-libmpeg3"
	fi
	if [ "$DEBUG" ] ; then
		myconf="$myconf --enable-debug"
	else
		myconf="$myconf --disable-debug"
	
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
	  	    --enable-jpeg					\
		    --enable-png					\
		    --enable-gif 					\
		    $myconf || die

	if [ "`use libmpeg3`" ] ; then
		make LIBMPEG3_DIR=/usr/lib LIBMPEG3_LIBS=-lmpeg3 || die
	else
		make || die
	fi
}

src_install () {
	if [ "`use libmpeg3`" ] ; then
       		make DESTDIR=${D}					\
		     LIBMPEG3_DIR=/usr/lib 				\
		     LIBMPEG3_LIBS=-lmpeg3				\
		     install || die
	else
		make DESTDIR=${D} install || die
    	fi

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
	docinto html
	dodoc docs/html/*.{png,html}
}
