# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.6.11.ebuild,v 1.1 2000/12/28 11:16:32 achim Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A minimal libc"
SRC_URI="http://www.fefe.de/dietlibc/dietlibc-0.6.11.tar.bz2"
HOMEPAGE="http://www.fefe.de/dietlibc"


src_unpack() {
  unpack ${A}
  mkdir ${S}/include/asm
  cp /usr/src/linux/include/asm/posix_types.h ${S}/include/asm
}

src_compile() {

    try make

}

src_install () {

    cd ${S}
    dodir /usr/include/dietlibc
    cp -a include/* ${D}/usr/include/dietlibc
    dolib.a dietlibc.a

    dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO


}

