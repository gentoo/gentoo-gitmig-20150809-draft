# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-glibc-2_1_97-sdk-2.96.20000731-r1.ebuild,v 1.3 2000/11/10 16:00:11 achim Exp $

P=gcc-2.96.20000731
A="gcc-2.96-20000731.tar.bz2 libg++-2.8.1.3.tar.gz libg++-2.8.1.3-20000914.diff.gz"
S=${WORKDIR}/gcc-2.96-20000731

export GLIBCV="2.1.97"
export TCPU="i686"
export THOST="${TCPU}-glibc${GLIBCV}-linux"

T=/usr/${THOST}

DESCRIPTION="modern gcc c/c++ compiler"
SRC_URI="ftp://ftp.eos.hokudai.ac.jp/pub/Linux/Kondara/Jirai/SOURCES/gcc-2.96-20000731.tar.bz2
	 ftp://sourceware.cygnus.com/pub/gcc/infrastructure/libg++-2.8.1.3.tar.gz
	 ftp://sourceware.cygnus.com/pub/gcc/infrastructure/libg++-2.8.1.3-20000914.diff.gz
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3.tar.gz
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000914.diff.gz"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

src_unpack() {
    unpack gcc-2.96-20000731.tar.bz2
#    unpack libg++-2.8.1.3.tar.gz
#    cd ${S}/../libg++-2.8.1.3
#    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000914.diff.gz | patch -p1
#    einfo "Moving trees"
#    cd ${S}
#    rm -rf texinfo
#    mv ../libg++-2.8.1.3/* .
#    rmdir ../libg++-2.8.1.3
     cp ${FILESDIR}/libioP.h ${S}/libio
}

src_compile() {                           
	cd ${S}
#	export CFLAGS="${CFLAGS} -I. -I${T}/${THOST}include"
#	export CXXFLAGS="${CXXFLAGS} -I. -I${T}/${THOST}/include"
	export PATH=.:${T}/bin:$PATH
	try  ${S}/configure --host=${CHOST} --target=${THOST} \
			--prefix=${T} --enable-version-specific-runtime-libs \
			--enable-threads --enable-shared \
		        --with-local-prefix=${T}/local --enable-nls \
			--with-gnu-ld --with-gnu-as \
			--with-gxx-include-dir=${T}/include/g++	\
			--oldincludedir=${T}/${THOST}/include
		 
	try make LANGUAGE="c"
	cd gcc 
	try make stage1 
	cd stage1
	cp specs specs.orig
	sed -e "s:-dynamic-linker /lib/ld-linux.so.2:-dynamic-linker ${T}/${THOST}/lib/ld-linux.so.2 -rpath ${T}/${THOST}/lib:" specs.orig > specs
	cd ../..
	try make CC=\"stage1/xgcc -Bstage1/\" CFLAGS=\"${CFLAGS}\" LIBGCC1="libgcc1.a" OLDCC="./xgcc"
}

src_install() {      
	export PATH=${T}/bin:${PATH}
	try make install prefix=${D}/${T} mandir=${D}${T}/man \
		gxx_include_dir=${D}${T}/include/g++ \
		CC="stage1/xgcc -Bstage1/" CFLAGS="$CFLAGS"
		
        FULLPATH=${D}${T}/lib/gcc-lib/${THOST}/${PV}
	cd ${FULLPATH}
	dodir ${T}/lib
	dosym	${T}/lib/gcc-lib/${THOST}/${PV}/cpp ${T}/lib/cpp
	dosym   ${T}/bin/gcc ${T}/bin/cc
	cd ${S}
	dodoc COPYING COPYING.LIB README FAQ MAINTAINERS
}





