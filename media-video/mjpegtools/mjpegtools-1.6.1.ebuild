# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.6.1.ebuild,v 1.3 2003/04/15 02:28:14 seemant Exp $

IUSE="sse arts gtk mmx sdl X quicktime 3dnow avi"

inherit libtool flag-o-matic base

S="${WORKDIR}/${P}"
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
	>=sys-apps/sed-4.0.5
	x86? ( media-libs/libmovtar )
	avi? ( media-video/avifile )
	quicktime? ( >=media-libs/quicktime4linux-1.5.5-r1 )
	mmx? ( >=media-libs/jpeg-mmx-1.1.2-r1 )
	mmx? ( dev-lang/nasm )
	3dnow? ( dev-lang/nasm )
	sse? ( dev-lang/nasm )
	media-libs/libdv
	arts? ( kde-base/arts )"


src_unpack() {
	base_src_unpack
	
	if [ ! -z "`use quicktime`" ]
	then
		cd ${WORKDIR}/quicktime4linux-1.4-patch
		sed -i "s:\"jpeg/jpeglib.h\":<jpeglib.h>:" libmjpeg.h
		sed -i "s:\"jpeg/jpeglib.h\":<jpeglib.h>:" jpeg_old.h

		# Don't remove this!!!
		# Contact phoen][x <phoenix@gentoo.org> if you have problems with it.
		cd ${S}/lavtools
		sed -i "s/dv_decoder_new(0,0,0)\;/dv_decoder_new()\;/" lav_common.c
		sed -i "s/dv_decoder_new(0,0,0)\;/dv_decoder_new()\;/" lav_io.c
	fi
}

src_compile() {
	elibtoolize

	local myconf=""

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
	
	if [ ! -z "`use quicktime`" ]
	then
		einfo "Building quicktime4linux"
		myconf="${myconf} --with-quicktime=${WORKDIR}/quicktime4linux-1.4-patch"
		
		cd ${WORKDIR}/quicktime4linux-1.4-patch
		./configure || die
		make || die
		cd ${S}
	fi

	einfo "Building mjpegtools"
	econf ${myconf} || die
	emake || die
}

src_install() {

	einstall || die

	dodoc mjpeg_howto.txt
}

