# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Heavily modified by Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.5.20011611-r1.ebuild,v 1.1 2001/12/11 19:39:34 ryan Exp $

A=${PN}-1.5-20011611.tar.gz
S=${WORKDIR}/${PN}-1.5-20011611
DESCRIPTION="Tools for MJPEG video"
SRC_URI="http://download.sourceforge.net/mjpeg/${A}
	 quicktime? ( http://download.sourceforge.net/mjpeg/quicktime4linux-1.4-patched.tar.gz )"
HOMEPAGE="http://mjpeg.sourceforge.net/"

DEPEND="virtual/glibc
	>=sys-devel/automake-1.5-r1
	>=media-libs/jpeg-6b
	gtk? ( >=x11-libs/gtk+-1.2.10 )
	sdl? ( >=media-libs/libsdl-1.2.2 )
	X? ( >=x11-base/xfree-4.1.0 )
	quicktime? ( >=media-libs/libpng-1.0.12 )
	avifile? ( >=media-video/avifile-0.6.0.20011130 )
	libmovtar? ( >=media-libs/libmovtar-0.1.2 )
	mmx? ( >=media-libs/jpeg-mmx-1.1.2 )"

RDEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
	sdl? ( >=media-libs/libsdl-1.2.2 )
	X? ( >=x11-base/xfree-4.1.0 )
	avifile? ( >=media-video/avifile-0.6.0.20011130 )"

src_unpack() {
	
	unpack ${A}
	cd quicktime4linux-1.4-patch
	cp libmjpeg.h libmjpeg.h.orig
	sed -e "s:\"jpeg/jpeglib.h\":<jpeglib.h>:" libmjpeg.h.orig > libmjpeg.h
	cp jpeg_old.h jpeg_old.h.orig
	sed -e "s:\"jpeg/jpeglib.h\":<jpeglib.h>:" jpeg_old.h.orig > jpeg_old.h

}

src_compile() {

	local myconf

	if [ "`use gtk`" ] ; then
		myconf="${myconf} --with-gtk-prefix=/usr"
	else
		myconf="${myconf} --with-gtk-prefix=/"
	fi
	if [ "`use X`" ] ; then
		myconf="${myconf} --with-x"
	else
		myconf="${myconf} --without-x"
	fi
	if [ "`use mmx`" ] ; then
		myconf="${myconf} --with-jpeg-mmx=/usr/include/jpeg-mmx --enable-mmx-accel"
	fi
	if [ -z "`use avifile`" ] ; then
		myconf="${myconf} --without-aviplay"
	fi
	if [ "`use quicktime`" ] ; then
		myconf="${myconf} --with-quicktime=${WORKDIR}/quicktime4linux-1.4-patch"
		cd ${WORKDIR}/quicktime4linux-1.4-patch
		try ./configure
		try make
	fi

	cd ${S}
	try ./configure ${myconf}
	try make

}

src_install () {

	try make prefix=${D}/usr mandir=${D}/usr/share/man install
	dodoc mjpeg_howto.txt

}
