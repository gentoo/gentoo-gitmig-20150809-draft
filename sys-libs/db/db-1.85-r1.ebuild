# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-1.85-r1.ebuild,v 1.31 2005/01/30 19:39:20 pauldv Exp $

inherit eutils

DESCRIPTION="db 1.85 -- required for RPM 4.0 to compile; that's about it."
HOMEPAGE="http://www.sleepycat.com/"
SRC_URI="ftp://ftp.sleepycat.com/releases/db.${PV}.tar.gz"

LICENSE="DB"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc"

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
	dosym libdb1.so.2 /usr/$(get_libdir)/libdb1.so
	dosym libdb1.so.2 /usr/$(get_libdir)/libdb.so.2
	dosym libdb1.so.2 /usr/$(get_libdir)/libndbm.so
	dosym libdb1.a /usr/$(get_libdir)/libndbm.a

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
