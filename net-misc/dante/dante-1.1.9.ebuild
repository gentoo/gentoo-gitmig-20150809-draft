# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dante/dante-1.1.9.ebuild,v 1.1 2001/04/27 05:34:50 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A free socks4,5 and msproxy implemetation"
SRC_URI="ftp://ftp.inet.no/pub/socks/${A}"
HOMEPAGE="http://www.inet.no/dante/"

DEPEND="virtual/glibc "

src_compile() {
    local myconf
    if [ -z "`use tcpd`" ]
    then
        myconf="--disable-libwrap"
    fi
    if [ "$DEBUG" ]
    then
        myconf="$myconf --enble-debug"
    fi

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} $myconf \
	--with-socks-conf=/etc/socks/socks.conf --with-sockd-conf=/etc/socks/sockd.conf 
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodir /etc/socks
    dodoc BUGS CREDITS LICENSE NEWS README SUPPORT TODO VERSION 
    docinto txt
    cd doc
    dodoc README* *.txt SOCKS4.*
    docinto example
    cd ../example
    dodoc *.conf
}

