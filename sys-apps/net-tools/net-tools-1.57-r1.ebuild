# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.57-r1.ebuild,v 1.7 2000/12/24 09:55:16 achim Exp $

P=net-tools-1.57
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="standard Linux network tools"
SRC_URI="http://www.tazenda.demon.co.uk/phil/net-tools/${A}"
DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
	try make ${MAKEOPTS}
	cd po
	try make ${MAKEOPTS}

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
	try make BASEDIR=${D} install 
	mv ${D}/bin/* ${D}/sbin   
	for i in hostname domainname netstat
	do
	  mv ${D}/sbin/${i} ${D}/bin
	done                       
	dodoc COPYING README README.ipv6 TODO
}



