# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/pspell/pspell-0.12.2.ebuild,v 1.2 2002/04/27 23:08:35 bangert Exp $

A=${PN}-.12.2.tar.gz
S=${WORKDIR}/${PN}-.12.2
DESCRIPTION="A spell checker frontend for aspell and ispell"
SRC_URI="http://download.sourceforge.net/pspell/${A}"
HOMEPAGE="http://pspell.sourceforge.net"

DEPEND="virtual/glibc"


src_compile() {

    try ./configure --prefix=/usr --enable-doc-dir=/usr/share/doc/${P} --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    cd ${D}/usr/share/doc/${P}
    mv man-html html
    mv man-text txt
    cd ${S}
    dodoc README*

}
