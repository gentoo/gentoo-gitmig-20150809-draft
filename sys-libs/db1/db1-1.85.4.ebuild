# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db1/db1-1.85.4.ebuild,v 1.1 2000/11/14 19:20:55 achim Exp $

#P=
A=db-${PV}-src.tar.gz
S=${WORKDIR}/db.${PV}
DESCRIPTION="The Berkley DB 1.85"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/libs/db/${A}"
HOMEPAGE="http://"

src_unpack() {
  unpack ${A}
  cd ${S}
  patch -p1 < ${FILESDIR}/db.1.85.patch
}
src_compile() {

    cd ${S}/PORT/linux
    try make OORG=\"${CFLAGS} -fomit-frame-pointer\" prefix=/usr

}

src_install () {

    cd ${S}/PORT/linux
    dodir /usr/lib
    dodir /usr/include
    try make prefix=${D}/usr install

}


