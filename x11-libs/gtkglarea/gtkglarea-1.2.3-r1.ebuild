# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.2.3-r1.ebuild,v 1.6 2002/10/04 06:39:07 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GL Extentions for gtk+"
SRC_URI="http://www.student.oulu.fi/~jlof/gtkglarea/download/${P}.tar.gz"
HOMEPAGE="http://www.student.oulu.fi/~jlof/gtkglarea/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	virtual/glu
	virtual/opengl"


src_compile() {

	./configure --prefix=/usr \
		--host=${CHOST} || die
		
	make || die
}

src_install() {

    make DESTDIR=${D} \
    	install || die
	
    dodoc AUTHORS COPYING ChangeLog NEWS README 
    docinto txt
    dodoc docs/*.txt
}
