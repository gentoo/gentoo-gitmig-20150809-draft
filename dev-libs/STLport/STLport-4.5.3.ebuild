# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-4.5.3.ebuild,v 1.2 2002/07/11 06:30:20 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C++ STL library"
SRC_URI="http://www.stlport.org/archive/${P}.tar.gz"
HOMEPAGE="http://www.stlport.org"

DEPEND="virtual/glibc"

src_compile() {

	cd ${S}/src
	make -f gcc-linux.mak
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

