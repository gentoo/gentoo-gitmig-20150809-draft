# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# /home/cvsroot/gentoo-x86/skel.build,v 1.3 2001/07/05 02:43:36 drobbins Exp

S=${WORKDIR}/${P}

DESCRIPTION="gv is a standard ghostscript frontend used e.g. by LyX"

SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gv/unix/${P}.tar.gz"
HOMEPAGE="http://wwwthep.physik.uni-mainz.de/~plass/gv/"

# There's probably more, but ghostscript also depends on it,
# so I can't identify it
DEPEND="virtual/x11 x11-libs/Xaw3d app-text/ghostscript"

src_unpack() {
    
    # need to check if this can be done automatically
    
    unpack ${P}.tar.gz
    cd ${S}
    patch -p0 <${FILESDIR}/${P}-gentoo-1.diff
    
}

src_compile() {
    
    cd ${S}
    
    # emake may not work
    try xmkmf
    try make Makefiles

    patch -p0 <${FILESDIR}/${P}-gentoo-2.diff

    try make
    
}

src_install () {
    
    cd ${S}
    try make DESTDIR=${D} install
    try make DESTDIR=${D} install.man
    try make DESTDIR=${D} install.doc
    gzip ${D}/usr/man/man1/gv.1x
    
}

