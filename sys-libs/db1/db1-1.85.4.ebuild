# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db1/db1-1.85.4.ebuild,v 1.3 2000/11/17 00:30:17 achim Exp $

#P=
A=db-${PV}-src.tar.gz
S=${WORKDIR}/db.${PV}
DESCRIPTION="The Berkley DB 1.85"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/libs/db/${A}"
HOMEPAGE="http://"

DEPEND=">=sys-libs/glibc-2.2
	!sys-libs/glibc-2.1.3"

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

    cd ${S}
    insinto /usr/include/db1
    doins include/db.h include/mpool.h PORT/linux/include/ndbm.h
    dosed "s:<db.h>:<db1/db.h>;" /usr/include/ndbm.h
    cd ${S}/PORT/linux 
    insinto /usr/lib
    insopts -m 755 -o root -g root
    donewins ${S}/PORT/linux/libdb.a libdb1.a
    donewins ${S}/PORT/linux/libdb.so.1.85.4 libdb1.so.1.85.4
    dosym /usr/lib/libdb.so.1.85.4 /usr/lib/libdb1.so
    dosym /usr/lib/libdb.so.1.85.4 /usr/lib/libdb.so.1
    dosym /usr/lib/libdb.so.1.85.4 /usr/lib/libdb.so.1.85.4
    

}


