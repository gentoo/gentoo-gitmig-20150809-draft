# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.6.1.ebuild,v 1.12 2004/03/30 04:44:11 spyderous Exp $

inherit gcc libtool flag-o-matic base

DESCRIPTION="Tools for MJPEG video"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${P}.tar.gz
	 quicktime? ( mirror://sourceforge/mjpeg/quicktime4linux-1.4-patched.tar.gz )"

LICENSE="as-is"
SLOT="1"
KEYWORDS="x86 -ppc"
IUSE="sse arts gtk mmx sdl X quicktime 3dnow avi"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	gtk? ( =x11-libs/gtk+-1.2* )
	X? ( virtual/x11 )
	sdl? ( media-libs/libsdl )
	media-libs/libdv
	arts? ( kde-base/arts )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5
	x86? ( media-libs/libmovtar )
	avi? ( <media-video/avifile-0.7.38 )
	quicktime? ( virtual/quicktime )
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

		if [ "`gcc-major-version`" -eq "3" ] ; then
		# Don't remove this!!!
		# Contact phoen][x <phoenix@gentoo.org> if you have problems with it.
		cd ${S}/lavtools
		sed -i "s/dv_decoder_new(0,0,0)\;/dv_decoder_new()\;/" lav_common.c
		sed -i "s/dv_decoder_new(0,0,0)\;/dv_decoder_new()\;/" lav_io.c
		fi
	fi
}

src_compile() {
	elibtoolize

	local myconf=""

	replace-flags "-march=pentium4" "-march=i686"
	replace-flags "-march=athlon*" "-march=i686"
	filter-flags "-mfpmath=sse"

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
