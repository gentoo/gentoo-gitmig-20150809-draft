# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-glibc-2_1_97-sdk-2.95.2-r1.ebuild,v 1.1 2000/11/08 10:57:01 achim Exp $

P=gcc-2.95.2
A="gcc-2.95.2.tar.gz libg++-2.8.1.3.tar.gz libg++-2.8.1.3-20000816.diff.gz"
A0=gcc-2.95.2.dif.gz
A1=gcc-exception-fix.diff.gz
A2=gcc-accept-doublecolon.diff.gz
S=${WORKDIR}/gcc-2.95.2

export GLIBCV="2.1.97"
export TCPU="i686"
export THOST="${TCPU}-glibc${GLIBCV}-linux"
export TALIAS=${THOST}

T=/usr/${TALIAS}

DESCRIPTION="modern gcc c/c++ compiler"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gcc/gcc-2.95.2.tar.gz 
	 ftp://gatekeeper.dec.com/pub/GNU/gcc/gcc-2.95.2.tar.gz 
	 ftp://sourceware.cygnus.com/pub/gcc/infrastructure/libg++-2.8.1.3.tar.gz
	 ftp://sourceware.cygnus.com/pub/gcc/infrastructure/libg++-2.8.1.3-20000816.diff.gz
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3.tar.gz
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000816.diff.gz"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

src_unpack() {
    unpack gcc-2.95.2.tar.gz
    unpack libg++-2.8.1.3.tar.gz
    cd ${S}/../libg++-2.8.1.3
    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000816.diff.gz | patch -p1
    einfo "Moving trees"
    cd ${S}
    rm -rf texinfo
    mv ../libg++-2.8.1.3/* .
    rmdir ../libg++-2.8.1.3
    zcat ${O}/files/${A0} | patch -p0
    zcat ${O}/files/${A1} | patch -p0
    zcat ${O}/files/${A2} | patch -p0
}

src_compile() {                           
	cd ${S}
	export PATH=${T}/bin:$PATH
	try CFLAGS=\"$CFLAGS -I${T}/include\" CXXFLAGS=\"$CXXFLAGS -I${T}/include\"\
	 ${S}/configure --host=${CHOST} --target=${THOST} \
			--prefix=${T} --enable-version-specific-runtime-libs \
			--enable-threads --enable-shared \
		        --with-local-prefix=${T}/local --enable-nls \
			--with-gnu-ld --with-gnu-as \
			--with-gxx-include-dir=${T}/include/g++
		 
	try make target_alias=${TALIAS}
	#try make bootstrap-lean
}

src_install() {      
	try make install prefix=${D}/usr mandir=${D}${T}/man \
		gxx_include_dir=${D}${T}/include/g++ \
		target_alias=${TALIAS}
		
        FULLPATH=${D}${T}/lib/gcc-lib/${THOST}/${PV}
	cd ${FULLPATH}
	dodir /lib
	dosym	${T}/lib/gcc-lib/${THOST}/${PV}/cpp /lib/cpp
	dosym   ${T}/bin/gcc ${T}/bin/cc
	cd ${S}
	dodoc COPYING COPYING.LIB README FAQ MAINTAINERS
}





