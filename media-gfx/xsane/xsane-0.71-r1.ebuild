# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.71-r1.ebuild,v 1.1 2001/03/09 16:32:38 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XSane is a graphical scanning frontend"
SRC_URI="http://www.xsane.org/download/${A}"
HOMEPAGE="http://www.xsane.org"


src_compile() {

    try ./configure --prefix=/usr/X11R6 --mandir=/usr/X11R6/share/man --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr/X11R6 mandir=${D}/usr/X11R6/share/man install
    dodoc xsane.[A-Z]*
    docinto html
    dodoc doc/*.{jpg,html}
}

