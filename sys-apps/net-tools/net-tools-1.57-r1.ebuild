# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.57-r1.ebuild,v 1.4 2000/10/03 16:02:05 achim Exp $

P=net-tools-1.57
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="standard Linux network tools"
SRC_URI="http://www.tazenda.demon.co.uk/phil/net-tools/${A}"

src_compile() {                           
	try make
	cd po
	try make

}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp ${O}/files/config.h .
    cp ${O}/files/config.make .
    mv Makefile Makefile.orig
    sed -e "s/-O2 -Wall -g/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
	into /
	dosbin arp hostname ifconfig netstat plipconfig rarp route 
	dosbin slattach iptunnel ipmaddr
	cd po
	try make BASEDIR=${D} install
	cd ..
	doman man/en_US/*.[18]
	dodoc COPYING README README.ipv6 TODO
}



