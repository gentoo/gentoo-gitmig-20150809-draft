# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ttf2pt1/ttf2pt1-3.3.3.ebuild,v 1.1 2001/03/20 06:43:35 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Converts True Type to Type 1 fonts"
SRC_URI="http://download.sourceforge.net/ttf2pt1/${A}"
HOMEPAGE="http://ttf2pt1.sourceforge.net"

DEPEND="virtual/glibc"

src_unpack() {
    unpack ${A}
    patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff
}

src_compile() {

    try make CFLAGS=\"${CFLAGS}\" all

}

src_install () {

    try make INSTDIR=${D}/usr install
    dodir /usr/share/doc/${PF}/html
    cd ${D}/usr/share/ttf2pt1
    rm -r app other
    mv *.html ../doc/${PF}/html
    mv [A-Z]* ../doc/${PF}
    prepalldocs 
}

