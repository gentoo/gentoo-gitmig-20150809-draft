# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-4.5.3-r2.ebuild,v 1.1 2002/09/13 17:45:43 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C++ STL library"
SRC_URI="http://www.stlport.org/archive/${P}.tar.gz"
HOMEPAGE="http://www.stlport.org"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 sparc sparc64"
LICENSE="as-is"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gcc3.patch2 || die "Patching failed"
	patch -p1 < ${FILESDIR}/${P}-optimize.patch || die "Patching failed"
}

src_compile() {
	cd src
	emake -f gcc-linux.mak || die "Compile failed"
}

src_install () {

	dodir /usr/include
	cp -R ${S}/stlport ${D}/usr/include
	rm -rf ${D}/usr/include/stlport/BC50
		
	dodir /usr/lib
	cp -R ${S}/lib/* ${D}/usr/lib/
	rm -rf ${D}/usr/lib/obj
	
	cd ${S}/etc/
	dodoc ChangeLog* README TODO *.txt

	cd ${S}
	dohtml -r doc
}
