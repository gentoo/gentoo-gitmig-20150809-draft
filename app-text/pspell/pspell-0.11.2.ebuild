# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/pspell/pspell-0.11.2.ebuild,v 1.3 2001/05/28 05:24:13 achim Exp $

A=${PN}-.11.2.tar.gz
S=${WORKDIR}/${PN}-.11.2
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://download.sourceforge.net/pspell/${A}"
HOMEPAGE="http://pspell.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --enable-doc-dir=/usr/doc/${P} --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    cd ${D}/usr/doc/${P}
    mv man-html html
    cd ${S}
    dodoc README*

}


