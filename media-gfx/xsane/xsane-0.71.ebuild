# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.71.ebuild,v 1.1 2001/03/09 10:26:59 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XSane is a graphical scanning frontend"
SRC_URI="http://www.xsane.org/download/${A}"
HOMEPAGE="http://www.xsane.org"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr/X11R6 install

}

