# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmovtar/libmovtar-0.1.3.ebuild,v 1.1 2002/05/31 01:33:26 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Movtar tools and library for MJPEG video"
SRC_URI="http://download.sourceforge.net/mjpeg/${P}.tar.gz"
HOMEPAGE="http://mjpeg.sourceforge.net/"

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	=dev-libs/glib-1.2*
	>=media-libs/libsdl-1.2.2
	mmx? ( media-libs/jpeg-mmx )"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/jpegint.h .
	cp movtar_play.c movtar_play.c.orig
	sed -e "s:#include <jinclude.h>::" movtar_play.c.orig > movtar_play.c

}
