# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-4.5.ebuild,v 1.1 2001/09/15 23:06:03 karltk Exp $

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
	
	dodoc ${S}/doc/*
	dodoc ${S}/etc/*

	dodir usr/share/doc/STLport-4.5/html
	
	mv ${D}/usr/share/doc/STLport-4.5/*.html.gz \
	   ${D}/usr/share/doc/STLport-4.5/html/ 
	   
}
	

