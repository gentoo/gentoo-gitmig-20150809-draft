# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmovtar/libmovtar-0.1.2.ebuild,v 1.3 2002/04/12 18:59:19 spider Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Movtar tools and library for MJPEG video"
SRC_URI="http://download.sourceforge.net/mjpeg/${A}"

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	=dev-libs/glib-1.2*
	sdl? ( >=media-libs/libsdl-1.2.2 )"

RDEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	=dev-libs/glib-1.2*
	sdl? ( >=media-libs/libsdl-1.2.2 )"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/jpegint.h .
	cp movtar_play.c movtar_play.c.orig
	sed -e "s:#include <jinclude.h>::" movtar_play.c.orig > movtar_play.c

}

src_compile() {

	local myconf

	if [ -z "`use sdl`" ] ; then
		myconf="--with-sdl-prefix=/"
	fi

	try ./configure ${myconf}
	try make

}

src_install() {

	try make prefix=${D}/usr install

}
