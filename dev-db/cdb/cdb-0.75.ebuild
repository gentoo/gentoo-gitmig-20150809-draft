# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/cdb/cdb-0.75.ebuild,v 1.7 2003/07/31 13:51:00 taviso Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A fast, reliable, simple package for creating and reading constant databases"
SRC_URI="http://cr.yp.to/cdb/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/cdb.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~alpha"

DEPEND=">=sys-apps/portage-2.0.47-r10
	sys-apps/tar
	sys-apps/gzip"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-errno.diff
}

src_compile() {                           
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr" > conf-home
	emake || die "emake failed"
}

src_install() {                               
	exeinto /usr/bin
	for i in cdbdump cdbget cdbmake cdbmake-12 cdbmake-sv cdbstats cdbtest
	do
		doexe $i
	done

	into /usr
	newlib.a cdb.a libcdb.a
	insinto /usr/include
	doins cdb.h

	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}
