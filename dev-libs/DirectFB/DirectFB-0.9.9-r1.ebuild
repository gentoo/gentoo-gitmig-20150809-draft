# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.9-r1.ebuild,v 1.1 2002/04/12 21:09:14 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux framebuffer devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"
HOMEPAGE="http://www.directfb.org"

DEPEND="sys-devel/perl
	>=media-libs/freetype-2.0.1
	>=media-libs/jpeg-6
	>=media-libs/libpng-1.2.1
	>=media-libs/libflash-0.4.10
	avi? ( =media-video/avifile-0.6* )
	libmpeg3? ( >=media-libs/libmpeg3-1.2.3 )"

RDEPEND="${DEPEND}"

extralibinfo=""
use libmpeg3 && extralibinfo="LIBMPEG3_DIR=/usr/lib LIBMPEG3_LIBS=-lmpeg3"

src_compile() {

    use mmx	\
      && myconf="--enable-mmx"	\
      || myconf="--disable-mmx"

# avifile that is in portage currently does not work with directfb
# an older one in the 0.6.0 series is required.
#	use avi	\
#      && myconf="${myconf} --enable-avifile"	\
#      || myconf="${myconf} --disable-avifile"
    
	use libmpeg3	\
      && myconf="${myconf} --with-libmpeg3=/usr/include/libmpeg3"	\
      && mkdir ${S}/interfaces/IDirectFBVideoProvider/no	\
      && cp /usr/lib/libmpeg3.a ${S}/interfaces/IDirectFBVideoProvider/no	\
      || myconf="${myconf} --disable-libmpeg3"
    
	
	if [ "$DEBUG" ] ; then
      myconf="${myconf} --enable-debug"
    else
      myconf="${myconf} --disable-debug"
    fi
	
    ./configure	\
		--prefix=/usr 	\
		--host=${CHOST}	\
		--disable-avifile	\
		--enable-jpeg 	\
		--enable-png	\
		--enable-gif	\
		${myconf} || die

	make 	\
		${extralibinfo} || die

}

src_install () {
	
	insinto /etc
	doins fb.modes

	make 	\
	   	${extralibinfo} 	\
		DESTDIR=${D}	\
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
	dohtml -r docs/html
}
