# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.6.0-r3.ebuild,v 1.2 2002/08/30 10:36:04 danarmak Exp $

inherit libtool

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
	quicktime? ( >=media-libs/quicktime4linux-1.5.5-r1 )
	mmx? ( >=media-libs/jpeg-mmx-1.1.2-r1 )
	mmx? ( dev-lang/nasm )
	3dnow? ( dev-lang/nasm )
	sse? ( dev-lang/nasm )
	media-libs/libdv
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
	cd quicktime4linux-1.4-patch
	cp libmjpeg.h libmjpeg.h.orig
	sed -e "s:\"jpeg/jpeglib.h\":<jpeglib.h>:" libmjpeg.h.orig > libmjpeg.h
	cp jpeg_old.h jpeg_old.h.orig
	sed -e "s:\"jpeg/jpeglib.h\":<jpeglib.h>:" jpeg_old.h.orig > jpeg_old.h
	elibtoolize
}

src_compile() {

	local myconf

	use gtk	\
		&& myconf="${myconf} --with-gtk-prefix=/usr"
	
	use X	\
		&& myconf="${myconf} --with-x"	\
		|| myconf="${myconf} --without-x"
	
	use mmx	\
		&& myconf="${myconf} --with-jpeg-mmx=/usr/include/jpeg-mmx --enable-mmx-accel"
	
	use avi	\
		&& myconf="${myconf} --without-aviplay"
	
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

	make 	\
		prefix=${D}/usr	\
		mandir=${D}/usr/share/man	\
		install || die

	dodoc mjpeg_howto.txt

}
