# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.77-r1.ebuild,v 1.3 2002/07/11 06:30:38 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XSane is a graphical scanning frontend"
SRC_URI="http://www.xsane.org/download/${P}.tar.gz"
HOMEPAGE="http://www.xsane.org"

DEPEND="media-gfx/sane-backends media-gfx/gimp"

src_compile() {

	./configure --prefix=/usr --mandir=/usr/man --host=${CHOST} || die
	make || die

}

src_install () {

	make prefix=${D}/usr/ mandir=${D}/usr/man install || die
	dodoc xsane.[A-Z]*
	dohtml -r doc
}
