# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-1.85.ebuild,v 1.5 2000/12/24 14:00:14 achim Exp $

A=db.1.85.tar.gz
S=${WORKDIR}/db.1.85
DESCRIPTION="db 1.85 -- required for RPM 4.0 to compile; that's about it."
SRC_URI="http://www.sleepycat.com/update/1.85/db.1.85.tar.gz"
HOMEPAGE="http://www.sleepycat.com"
DEPEND=">=sys-libs/glibc-2.2 !sys-libs/glibc-2.1.3"
RDEPEND=$DEPEND
src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/db.1.85.patch
}

src_compile() {
    cd ${S}/PORT/linux
    try make ${MAKEOPTS} OORG=\"${CFLAGS} -fomit-frame-pointer\" prefix=/usr
}

src_install () {
	cd PORT/linux
	cp libdb.a libdb1.a
	dolib.a libdb1.a
	cp libdb.so.2 libdb1.so.2
	dolib.so libdb1.so.2
	dosym libdb1.so.2 /usr/lib/libdb1.so
	dosym libdb1.so.2 /usr/lib/libdb.so.2
	dosym libdb1.so.2 /usr/lib/libndbm.so
	dosym libdb1.a /usr/lib/libndbm.a
	dodir /usr/include/db1
	insinto /usr/include/db1
	doins ../include/ndbm.h ../../include/db.h ../../include/mpool.h
	dosed "s:<db.h>:<db1/db.h>;" /usr/include/ndbm.h
	cp db_dump185 db1_dump185
	dobin db1_dump185
	cd ${S}
	dodoc changelog README
	docinto ps
	dodoc docs/*.ps
	docinto hash
	dodoc hash/README
	
}


