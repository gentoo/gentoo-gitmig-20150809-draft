# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.3.ebuild,v 1.4 2000/11/02 08:31:52 achim Exp $

P=tcpstat-1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${A}"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=net-libs/libpcap-0.5.2"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    prepman
    dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}


