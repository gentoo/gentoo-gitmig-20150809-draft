# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-2.95.2-r4.ebuild,v 1.5 2001/01/31 20:49:07 achim Exp $

P=gcc-2.95.2
A="gcc-2.95.2.tar.gz 
   libg++-2.8.1.3.tar.gz 
   libg++-2.8.1.3-20000312.diff.gz
   libg++-2.8.1.3-20000419.diff.gz
   libg++-2.8.1.3-20000816.diff.gz
   libg++-2.8.1.3-20000914.diff.gz"

A0=gcc-2.95.2.dif.gz
A1=gcc-exception-fix.diff.gz
A2=gcc-accept-doublecolon.diff.gz
A3=gcc-glibc-2.2-compat.diff
S=${WORKDIR}/gcc-2.95.2
T=/usr

DESCRIPTION="modern gcc c/c++ compiler"

SRC_URI="ftp://prep.ai.mit.edu/gnu/gcc/gcc-2.95.2.tar.gz
	 ftp://gatekeeper.dec.com/pub/GNU/gcc/gcc-2.95.2.tar.gz 
	 ftp://sourceware.cygnus.com/pub/gcc/infrastructure/libg++-2.8.1.3.tar.gz
	 ftp://sourceware.cygnus.com/pub/gcc/infrastructure/libg++-2.8.1.3-20000816.diff.gz
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3.tar.gz
         ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000312.diff.gz
         ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000419.diff.gz
	 ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000816.diff.gz
         ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000914.diff.gz"

HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35-r1
        || ( sys-devel/flex sys-build/flex )"

RDEPEND="virtual/glibc
	 sys-apps/bash"

src_unpack() {
    unpack gcc-2.95.2.tar.gz
    unpack libg++-2.8.1.3.tar.gz
    cd ${S}/../libg++-2.8.1.3
    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000312.diff.gz | patch -p1
    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000419.diff.gz | patch -p1
    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000816.diff.gz | patch -p1
    gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000914.diff.gz | patch -p1
    einfo "Moving trees"
    cd ${S}
    #rm -rf texinfo
    mv ../libg++-2.8.1.3/* .
    rmdir ../libg++-2.8.1.3
    zcat ${FILESDIR}/${A0} | patch -p0
    zcat ${FILESDIR}/${A1} | patch -p0
    zcat ${FILESDIR}/${A2} | patch -p0
    patch -p0 < ${FILESDIR}/${A3}
}

src_compile() {
	cd ${S}
	#i586a doesn't like optimization?
	if [ "$PLATFORM" == "i686-pc-linux-gnu" ]
	then
	  export CFLAGS="-mpentium"
	  export CXXFLAGS="-mpentium"
	fi
	try ${S}/configure --prefix=${T} --enable-version-specific-runtime-libs \
		       --host=${CHOST} --enable-threads --enable-shared \
		        --with-local-prefix=${T}/local --enable-nls
	# Parallel build does not work
	try make ${MAKEOPTS} bootstrap-lean
}

src_install() {

	try make install prefix=${D}${T} mandir=${D}${T}/man
        FULLPATH=${D}${T}/lib/gcc-lib/${CHOST}/${PV}
	cd ${FULLPATH}
	dodir /lib
	dosym	${T}/lib/gcc-lib/${CHOST}/${PV}/cpp /lib/cpp
	dosym   /usr/bin/gcc /usr/bin/cc

	
	cd ${S}
	dodoc COPYING COPYING.LIB README* FAQ MAINTAINERS
	docinto html
	dodoc faq.html
	docinto gcc
	cd ${S}/gcc
	dodoc BUGS ChangeLog* COPYING* FSFChangeLog* \
	      LANGUAGES NEWS PROBLEMS README* \
	      SERVICE TESTS.FLUNK
	cd ${S}/libchill
	docinto libchill
	dodoc ChangeLog
	cd ${S}/libf2c
	docinto libf2c
	dodoc ChangeLog changes.netlib README TODO
	cd ${S}/libg++
	docinto libg++
	dodoc ChangeLog g++FAQ.txt NEWS README* TODO
	cd ${S}/libiberty
	docinto libiberty
	dodoc ChangeLog COPYING.LIB README
	cd ${S}/libio
	docinto libio
	dodoc ChangeLog NEWS README
	cd dbz
	docinto libio/dbz
	dodoc README
	cd ../stdio
	docinto libio/stdio
	dodoc ChangeLog*
	cd ${S}/libobjc
	docinto libobjc
	dodoc ChangeLog README* THREADS*
	cd ${S}/librx
	docinto librx
	dodoc ChangeLog COPYING.LIB DOC
	cd ${S}/libstdc++
	docinto libstdc++
	dodoc ChangeLog NEWS  
	
}





