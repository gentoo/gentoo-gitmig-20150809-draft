# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.6.0-r5.ebuild,v 1.3 2003/02/18 20:47:24 mholzer Exp $

IUSE="sse arts gtk mmx sdl X quicktime 3dnow avi"

inherit libtool flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Tools for MJPEG video"
SRC_URI="http://download.sourceforge.net/mjpeg/${P}.tar.gz
	 quicktime? ( http://download.sourceforge.net/mjpeg/quicktime4linux-1.4-patched.tar.gz )"
HOMEPAGE="http://mjpeg.sourceforge.net/"

LICENSE="as-is"
SLOT="1"
KEYWORDS="x86"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	=x11-libs/gtk+-1.2*
	X? ( x11-base/xfree )
	sdl? ( media-libs/libsdl )
	media-libs/libdv
	arts? ( kde-base/arts )"

DEPEND="${RDEPEND}
	media-libs/libmovtar
	avi? ( media-video/avifile )
	quicktime? ( >=media-libs/quicktime4linux-1.5.5-r1 )
	mmx? ( >=media-libs/jpeg-mmx-1.1.2-r1 )
	mmx? ( dev-lang/nasm )
	3dnow? ( dev-lang/nasm )
	sse? ( dev-lang/nasm )
	media-libs/libdv
	media-libs/svgalib
	arts? ( kde-base/arts )"

if [ `use mmx` ] ; then
	RDEPEND="$RDEPEND media-libs/jpeg-mmx"
	DEPEND="$DEPEND media-libs/jpeg-mmx"
fi

if [ `use mmx` ] || [ `use 3dnow` ] || [ `use sse` ] ; then
	DEPEND="$DEPEND dev-lang/nasm"
fi

src_unpack() {
	
	unpack ${A}
	if [ `use quicktime` ] ; then 
		cd quicktime4linux-1.4-patch
		cp libmjpeg.h libmjpeg.h.orig
		sed -e "s:\"jpeg/jpeglib.h\":<jpeglib.h>:" libmjpeg.h.orig > libmjpeg.h
		cp jpeg_old.h jpeg_old.h.orig
		sed -e "s:\"jpeg/jpeglib.h\":<jpeglib.h>:" jpeg_old.h.orig > jpeg_old.h
		elibtoolize
	fi
}

src_compile() {

	local myconf

	replace-flags "-march=pentium4" "-march=i686"
	replace-flags "-march=athlon*" "-march=i686"

	use gtk	\
		&& myconf="${myconf} --with-gtk-prefix=/usr"
	
	use X	\
		&& myconf="${myconf} --with-x"	\
		|| myconf="${myconf} --without-x"
	
	use mmx	\
		&& myconf="${myconf} --with-jpeg-mmx=/usr/include/jpeg-mmx --enable-mmx-accel"
	
	use avi	\
		|| myconf="${myconf} --without-aviplay"
	
	use quicktime && ( \
		myconf="${myconf} --with-quicktime=${WORKDIR}/quicktime4linux-1.4-patch"
		cd ${WORKDIR}/quicktime4linux-1.4-patch
		./configure || die
		make || die
	) 

	cd ${S}
	econf ${myconf} || die

	emake || die

}

src_install () {

	einstall || die

	dodoc mjpeg_howto.txt

}
