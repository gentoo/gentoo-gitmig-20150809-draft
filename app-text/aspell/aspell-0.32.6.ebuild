# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.32.6.ebuild,v 1.2 2000/12/01 21:58:44 achim Exp $


A=${PN}-.32.6.tar.gz
S=${WORKDIR}/${PN}-.32.6
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://download.sourceforge.net/aspell/${A}"
HOMEPAGE="http://aspell.sourceforge.net"

DEPEND=">=app-text/pspell-0.11.2"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    mv ${D}/usr/doc/aspell ${D}/usr/doc/${P}
    mv ${D}/usr/doc/${P}/man-html ${D}/usr/doc/${P}/html
    mv ${D}/usr/doc/${P}/man-text ${D}/usr/doc/${P}/aspell

    dodoc README* TODO

}

