# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-1.85-r1.ebuild,v 1.22 2003/12/17 04:19:25 brad_mssw Exp $

S=${WORKDIR}/db.${PV}
DESCRIPTION="db 1.85 -- required for RPM 4.0 to compile; that's about it."
SRC_URI="http://www.sleepycat.com/update/snapshot/db.${PV}.tar.gz"
HOMEPAGE="http://www.sleepycat.com"
DEPEND="virtual/glibc"
RDEPEND=$DEPEND
SLOT="1"
LICENSE="DB"
KEYWORDS="x86 ppc sparc alpha mips hppa arm ia64 amd64 ppc64"

src_unpack() {

	unpack db.${PV}.tar.gz
	cd ${S}
	patch -p1 < ${FILESDIR}/db.${PV}.patch

}

src_compile() {

	cd ${S}/PORT/linux
	make ${MAKEOPTS} OORG="${CFLAGS} -fomit-frame-pointer" prefix=/usr || die

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

	insinto /usr/include/db1
	doins include/ndbm.h
	dosed "s:<db.h>:<db1/db.h>:" /usr/include/db1/ndbm.h
	dosym db1/ndbm.h /usr/include/ndbm.h
	cp db_dump185 db1_dump185
	dobin db1_dump185

	cd ${S}
	dodoc changelog README
	docinto ps
	dodoc docs/*.ps
	docinto hash
	dodoc hash/README

}


