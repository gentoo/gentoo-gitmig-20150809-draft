# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.32.5.ebuild,v 1.1 2000/10/14 11:20:58 achim Exp $

P=${PN}-.32.5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://download.sourceforge.net/aspell/${A}"
HOMEPAGE="http://aspell.sourceforge.net"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

