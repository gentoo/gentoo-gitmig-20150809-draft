# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-1.85-r1.ebuild,v 1.25 2004/04/27 05:21:32 vapier Exp $

inherit eutils

DESCRIPTION="db 1.85 -- required for RPM 4.0 to compile; that's about it."
HOMEPAGE="http://www.sleepycat.com/"
SRC_URI="http://www.sleepycat.com/update/snapshot/db.${PV}.tar.gz"

LICENSE="DB"
SLOT="1"
KEYWORDS="x86 ppc sparc mips alpha arm hppa ia64 amd64 ppc64 s390"
IUSE=""

DEPEND="virtual/glibc"

S=${WORKDIR}/db.${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/db.${PV}.patch
}

src_compile() {
	cd ${S}/PORT/linux
	make ${MAKEOPTS} OORG="${CFLAGS} -fomit-frame-pointer" prefix=/usr || die
}

src_install () {
	cd ${S}/PORT/linux

	newlib.a libdb.a libdb1.a || die "newlib.a failed"
	newlib.so libdb.so.2 libdb1.so.2 || die "newlib.so failed"
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
	newbin db_dump185 db1_dump185

	cd ${S}
	dodoc changelog README
	docinto ps
	dodoc docs/*.ps
	docinto hash
	dodoc hash/README
}
