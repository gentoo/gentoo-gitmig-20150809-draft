# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.32.6.ebuild,v 1.3 2001/05/28 14:32:32 achim Exp $


A=${PN}-.32.6.tar.gz
S=${WORKDIR}/${PN}-.32.6
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://download.sourceforge.net/aspell/${A}"
HOMEPAGE="http://aspell.sourceforge.net"

DEPEND=">=app-text/pspell-0.11.2"

src_compile() {

    try ./configure --prefix=/usr --sysconfdir=/etc/aspell --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodir /usr/share/doc
    mv ${D}/usr/doc/aspell ${D}/usr/share/doc/${PF}
    mv ${D}/usr/share/doc/${PF}/man-html ${D}/usr/share/doc/${PF}/html
    mv ${D}/usr/share/doc/${PF}/man-text ${D}/usr/share/doc/${PF}/aspell

    dodoc README* TODO

}

