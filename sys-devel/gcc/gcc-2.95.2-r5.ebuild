# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-2.95.2-r5.ebuild,v 1.1 2001/02/07 16:05:19 achim Exp $


SRC_URI="ftp://prep.ai.mit.edu/gnu/gcc/gcc-2.95.2.tar.gz"

if [ "`use libg++`" ]
then
    SRC_URI="${SRC_URI}
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3.tar.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000312.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000419.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000816.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000914.diff.gz"
fi

A0=gcc-2.95.2.dif.gz
A1=gcc-exception-fix.diff.gz
A2=gcc-accept-doublecolon.diff.gz
A3=gcc-glibc-2.2-compat.diff
S=${WORKDIR}/gcc-2.95.2
T=/usr

DESCRIPTION="Modern GCC C/C++ compiler"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35-r1"

RDEPEND="virtual/glibc"

src_unpack() {

    unpack gcc-2.95.2.tar.gz

    if [ "`use libg++`" ]
    then
      unpack libg++-2.8.1.3.tar.gz
      cd ${S}/../libg++-2.8.1.3
      gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000312.diff.gz | patch -p1
      gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000419.diff.gz | patch -p1
      gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000816.diff.gz | patch -p1
      gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000914.diff.gz | patch -p1
      cd ${S}
      mv ../libg++-2.8.1.3/* .
      rmdir ../libg++-2.8.1.3
    fi

    cd ${S}
    zcat ${FILESDIR}/${A0} | patch -p0
    zcat ${FILESDIR}/${A1} | patch -p0
    zcat ${FILESDIR}/${A2} | patch -p0
    patch -p0 < ${FILESDIR}/${A3}

    # We do not build the included texinfo stuff
    rm -rf texinfo
}

src_compile() {

        # gcc does not like optimization

        export CFLAGS="${CFLAGS/-O?/}"
        export CXXFLAGS="${CXXFLAGS/-O?/}"

	try ${S}/configure --prefix=${T} --mandir=${T}/share/man --infodir=${T}/share/info \
                --enable-version-specific-runtime-libs \
                --host=${CHOST} --enable-threads --enable-shared \
                --with-local-prefix=${T}/local --enable-nls

	# Parallel build does not work
	try make ${MAKEOPTS} bootstrap-lean
}

src_install() {

	try make install prefix=${D}${T} mandir=${D}${T}/share/man infodir=${D}${T}/share/info

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
	
        if [ "`use libg++`" ]
        then
          cd ${S}/libg++
	  docinto libg++
	  dodoc ChangeLog g++FAQ.txt NEWS README* TODO
        else
          cd ${S}/libstdc++
	  docinto libstdc++
          dodoc ChangeLog NEWS
        fi


}





