# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-1.85-r1.ebuild,v 1.1 2001/02/07 16:10:52 achim Exp $

A=db.${PV}.tar.gz
S=${WORKDIR}/db.${PV}
DESCRIPTION="db 1.85 -- required for RPM 4.0 to compile; that's about it."
SRC_URI="http://www.sleepycat.com/update/${PV}/${A}"
HOMEPAGE="http://www.sleepycat.com"
DEPEND="virtual/glibc"
RDEPEND=$DEPEND

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/db.${PV}.patch

}

src_compile() {

    cd ${S}/PORT/linux
    try make ${MAKEOPTS} OORG=\"${CFLAGS} -fomit-frame-pointer\" prefix=/usr

}

src_install () {

	cd ${S}/PORT/linux

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
	doins include/db.h include/mpool.h
        insinto /usr/include
        doins include/ndbm.h
	dosed "s:<db.h>:<db1/db.h>:" /usr/include/ndbm.h

	cp db_dump185 db1_dump185
	dobin db1_dump185

	cd ${S}
	dodoc changelog README
	docinto ps
	dodoc docs/*.ps
	docinto hash
	dodoc hash/README

}


