# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/openvrml/openvrml-0.11.2.ebuild,v 1.1 2002/05/04 19:26:46 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="VRML97 library"
SRC_URI="http://prdownloads.sourceforge.net/openvrml/${P}.tar.gz"
HOMEPAGE="http://openvrml.org"

DEPEND="virtual/glibc
        virtual/x11
		sys-libs/zlib
		virtual/opengl
		media-libs/glut
		png? ( media-libs/libpng )
		jpeg? ( media-libs/libjpeg )"

# TODO: add support for java via libmozjs (http://www.mozilla.org/js/spidermonkey/)

src_compile() {

	use png && myconf="$myconf --with-libpng" || myconf="$myconf --without-libpng"
	use jpeg && myconf="$myconf --with-libjpeg" || myconf="$myconf --without-libjpeg"

	./configure --with-x --prefix=/usr --without-mozjs $myconf || die
		
	make || die

}

src_install() {

	make DESTDIR=${D} install || die
		
	dodoc AUTHORS COPYING ChangeLog NEWS README

}
