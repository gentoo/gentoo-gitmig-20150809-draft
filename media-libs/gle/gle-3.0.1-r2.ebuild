# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1-r2.ebuild,v 1.5 2002/07/16 11:36:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GL extrusion library"
SRC_URI="http://www.linas.org/gle/gle-3.0.1.tar.gz"
HOMEPAGE="http://www.linas.org/gle"

DEPEND="virtual/glibc
	virtual/opengl
	virtual/glu
	virtual/glut
    virtual/x11"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc"

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
	dohtml -r public_html
}
