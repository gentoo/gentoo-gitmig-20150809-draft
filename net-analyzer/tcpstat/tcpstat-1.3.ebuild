# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.3.ebuild,v 1.2 2000/08/16 04:38:13 drobbins Exp $

P=tcpstat-1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${A}"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"


src_compile() {

    cd ${S}
    ./configure --prefix=/usr --host=${CHOST}
    make

}

src_install () {

    cd ${S}
    make DESTDIR=${D} install
    prepman
    dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}


