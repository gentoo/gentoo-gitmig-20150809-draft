# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-3.3.11.ebuild,v 1.9 2002/10/04 06:36:50 vapier Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Berkeley DB"

SRC_URI="http://www.sleepycat.com/update/3.3.11/db-3.3.11.tar.gz"

HOMEPAGE="http://www.sleepycat.com"
SLOT="3"
LICENSE="DB"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {

	cd dist
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die
	emake || die
}

src_install () {
	cd dist

	make prefix=${D}/usr install || die
	
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/docs/* ${D}/usr/share/doc/${PF}/html/
}
