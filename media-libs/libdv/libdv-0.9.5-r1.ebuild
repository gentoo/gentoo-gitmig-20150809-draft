# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdv/libdv-0.9.5-r1.ebuild,v 1.1 2002/06/02 17:40:23 prez Exp $

S=${WORKDIR}/${P}
DESCRIPTION="software codec for dv-format video (camcorders etc)"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	ftp://download.sourceforge.net/pub/sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://${P}.sourceforge.net/"

DEPEND="sys-devel/gcc
	virtual/glibc
	virtual/x11
	sdl? ( media-libs/libsdl )
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	dev-util/pkgconfig"

src_compile() {

	use sdl && myconf="$myconf --enable-sdl" \
	        || myconf="$myconf --disable-sdl"

	unset CFLAGS CXXFLAGS
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		${myconf} || die
		
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
}

