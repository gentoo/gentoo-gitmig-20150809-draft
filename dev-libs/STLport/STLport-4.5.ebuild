# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-4.5.ebuild,v 1.4 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/${P}

DESCRIPTION="C++ STL library"

SRC_URI="http://www.stlport.org/archive/STLport-4.5.tar.gz"

HOMEPAGE="http://www.stlport.org"

DEPEND=""

src_compile() {

	cd ${S}/src
	make -f gcc-linux.mak
}

src_install () {

	dodir usr/include
	cp -R ${S}/stlport ${D}/usr/include
	rm -rf ${D}/usr/include/stlport/BC50
		
	dodir usr/lib
	cp -R ${S}/lib/* ${D}/usr/lib/
	rm -rf ${D}/usr/lib/obj
	
	cd ${S}/etc/
	dodoc ChangeLog* README TODO *.txt

	cd ${S}
	dohtml -r doc
}
