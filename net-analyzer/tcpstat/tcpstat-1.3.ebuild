# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.3.ebuild,v 1.5 2001/05/29 17:28:19 achim Exp $

P=tcpstat-1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${A}"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.5.2
        berkdb? ( <sys-libs/db-2 )"

RDEPEND="virtual/glibc
	>=net-libs/libpcap-0.5.2
        berkdb? ( <sys-libs/db-2 )"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    if [ "`use berkdb`" ] ; then
      dobin src/tcpprof
    fi
    dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}


