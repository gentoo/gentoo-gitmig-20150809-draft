# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.2.2-r1.ebuild,v 1.1 2001/10/06 10:08:20 azarah Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GL Extentions for gtk+"
SRC_URI="http://www.student.oulu.fi/~jlof/gtkglarea/download/${A}"
HOMEPAGE="http://www.student.oulu.fi/~jlof/gtkglarea/"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-1.2.10-r4
	virtual/glu
	virtual/opengl"


src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}


src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README 
    docinto txt
    dodoc docs/*.txt

}

