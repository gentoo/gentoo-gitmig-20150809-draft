# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-2.96.20001106.ebuild,v 1.1 2000/11/11 14:05:11 achim Exp $

A="gcc-20001106.tar.gz libg++-2.8.1.3.tar.gz libg++-2.8.1.3-20000914.diff.gz"

S=${WORKDIR}/gcc-20001106
T=/usr
DESCRIPTION="modern gcc c/c++ compiler"
SRC_URI="ftp://ftp.freesoftware.com/pub/sourceware/gcc/snapshots/2000-11-06/gcc-20001106.tar.gz
	 ftp://sourceware.cygnus.com/pub/gcc/infrastructure/libg++-2.8.1.3.tar.gz
	 ftp://sourceware.cygnus.com/pub/gcc/infrastructure/libg++-2.8.1.3-20000914.diff.gz
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3.tar.gz
	ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000914.diff.gz"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

src_unpack() {
    unpack gcc-20001106.tar.gz
#    unpack libg++-2.8.1.3.tar.gz
#    cd ${S}/../libg++-2.8.1.3
#    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000914.diff.gz | patch -p1
#    einfo "Moving trees"
#    cd ${S}
#    rm -rf texinfo
#    mv ../libg++-2.8.1.3/* .
#    rmdir ../libg++-2.8.1.3
}

src_compile() {                           
	cd ${S}
	try ${S}/configure --prefix=${T} --enable-version-specific-runtime-libs \
		       --host=${CHOST} --enable-threads --enable-shared \
		        --with-local-prefix=${T}/local --enable-nls \
			--with-gxx-include-dir=${T}/${CHOST}/include/g++ \
					       
	try make bootstrap-lean
}

src_install() {      
	try make install prefix=${D}${T} mandir=${D}${T}/man \
		gxx_include_dir=${D}${T}/${CHOST}/include/g++ 
	cd ${FULLPATH}
	dodir /lib
	dosym	${T}/lib/gcc-lib/${CHOST}/2.96/cpp /lib/cpp
	dosym   /usr/bin/gcc /usr/bin/cc
	cd ${S}
	dodoc COPYING COPYING.LIB README FAQ MAINTAINERS
}





