# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-4.0.ebuild,v 1.3 2002/08/01 11:40:14 seemant Exp $
# specially modified from the 4.5 ebuild for openoffice - danarmak

S=${WORKDIR}/${P}

DESCRIPTION="C++ STL library"

SRC_URI="http://www.stlport.org/archive/STLport-4.0.tar.gz"

HOMEPAGE="http://www.stlport.org"

DEPEND="sys-devel/gcc"

src_compile() {

	cd ${S}/src
	make -f gcc.mak clean all
}

src_install () {

	target=/usr/lib/${P}

	dodir ${target}/include
	cp -R ${S}/stlport ${D}/${target}/include
	rm -rf ${D}/${target}/include/stlport/BC50
		
	dodir ${target}/lib
	cp -R ${S}/lib/* ${D}/${target}/lib/
	rm -rf ${D}/${target}/lib/obj

	dodir usr/share/doc/${P}/html	
	cp -R ${S}/doc/* ${D}/usr/share/doc/${P}/html
	
	insinto /etc/env.d
	doins ${FILESDIR}/50${P}
	   
}
	

