# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gltt/gltt-2.5.2.ebuild,v 1.1 2002/01/26 21:00:27 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GL truetype library"
SRC_URI="http://gltt.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gltt.sourceforge.net/"

DEPEND="virtual/glibc
        virtual/opengl
        virtual/glut
        virtual/x11
	>=media-libs/freetype-1.3.1"
RDEPEND="$DEPEND"

src_compile() {

	./configure --with-x \
		--prefix=/usr \
		--with-ttf-dir=/usr || die
		
	make || die

}

src_install() {

	make DESTDIR=${D}/usr install || die
		
	dodoc AUTHORS COPYING ChangeLog NEWS README

}


