# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1-r2.ebuild,v 1.1 2002/01/24 18:26:18 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GL extrusion library"
SRC_URI="http://www.linas.org/gle/gle-3.0.1.tar.gz"
HOMEPAGE="http://www.linas.org/gle"

DEPEND="virtual/glibc
        virtual/opengl
	virtual/glu
        virtual/glut
        virtual/x11"

src_compile() {

	./configure --with-x \
		--prefix=/usr \
		--mandir=/usr/share/man || die
		
	make || die
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die
		
	dodoc AUTHORS COPYING ChangeLog NEWS README
	docinto html
	dodoc public_html/*.{gif,jpg,html}
}


