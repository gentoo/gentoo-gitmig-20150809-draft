# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4o-r1.ebuild,v 1.4 2000/11/30 23:15:06 achim Exp $

P=m4-1.4o      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU macro processor"
SRC_URI="ftp://ftp.seindal.dk/gnu/${A}"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"
DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
    try ./configure --prefix=/usr --with-modules --host=${CHOST}
    try make ${MAKEOPTS}
}

src_install() {                        
       
    cd ${S}
    try make DESTDIR=${D} install
    rm -rf ${D}/usr/include ${D}/usr/lib
    dodoc AUTHORS BACKLOG ChangeLog COPYING NEWS README* THANKS TODO
    docinto modules
    dodoc modules/README modules/TODO
    docinto html
    dodoc examples/WWW/*.htm

}


