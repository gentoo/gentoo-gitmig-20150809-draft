# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-1.85-r2.ebuild,v 1.4 2004/11/12 14:53:22 vapier Exp $

inherit eutils

DESCRIPTION="db 1.85 -- required for RPM 4.0 to compile; that's about it."
HOMEPAGE="http://www.sleepycat.com/"
SRC_URI="http://www.sleepycat.com/update/snapshot/db.${PV}.tar.gz
		 mirror://gentoo/db.${PV}.patch.gz"

LICENSE="DB"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/db.${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/db.${PV}.patch.gz
}

src_compile() {
	cd ${S}/PORT/linux
	make ${MAKEOPTS} OORG="${CFLAGS}" prefix=/usr || die
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
