# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.77.ebuild,v 1.1 2001/06/04 06:41:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XSane is a graphical scanning frontend"
SRC_URI="http://www.xsane.org/download/${A}"
HOMEPAGE="http://www.xsane.org"

DEPEND="media-gfx/sane-backends media-gfx/gimp"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --mandir=/usr/X11R6/man --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr/X11R6 mandir=${D}/usr/X11R6/man install
    dodoc xsane.[A-Z]*
    docinto html
    dodoc doc/*.{jpg,html}
}

