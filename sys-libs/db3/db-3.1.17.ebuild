# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db3/db-3.1.17.ebuild,v 1.2 2000/11/17 00:30:36 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}/build_unix
DESCRIPTION="The Berkeley DB"
SRC_URI="http://www.sleepycat.com/update/${PV}/${A}"
HOMEPAGE="http://www.sleepycat.com"

DEPEND=">=sys-libs/glibc-2.2
	!sys-libs/glibc-2.1.3
	sys-libs/db1"

src_compile() {

    cd ${S}
    try ../dist/configure --prefix=/usr --host=${CHOST} --enable-cxx \
	--enable-compat185 --enable-rpc --enable-shared --enable-shared \
	--enable-dump185

    # Build the static libs 

    echo
    echo "Building static libs..."
    make libdb=libdb-3.1.a libdb-3.1.a
    make libcxx=libdb_cxx-3.1.a libdb_cxx-3.1.a

    # Now comes the trick
    # Static link with old db-185 libraries.

    echo
    echo "Building db_dump185..."

    /bin/sh ./libtool --mode=compile cc -c ${CFLAGS} -g -g \
	-I/usr/include/db1 -I../dist/../include -D_REENTRANT \
	../dist/../db_dump185/db_dump185.c	

    cc -s -static -o db_dump185 db_dump185.lo -L/usr/lib -ldb1

    # Now comes the rest
 
    try make libdb=libdb-3.1.a libcxx=libdb_cxx-3.1.a LDFLAGS="-s"

}

src_install () {

    cd ${S}
    try make libdb=libdb-3.1.a libcxx=libcxx_3.1.a prefix=${D}/usr install
    dolib libdb-3.1.a libdb_cxx-3.1.a 
    insinto /usr/lib
    dolib libdb-3.1.la libdb_cxx-3.1.la 
    dodir /usr/doc/${P}/html
    mv ${D}/usr/docs ${D}/usr/doc/${P}/html/
    dodir /usr/include/db3
    mv ${D}/usr/include/*.h ${D}/usr/include/db3
    dosym /usr/include/db3/db.h /usr/include/db.h
    preplib /usr
    cd ..
    dodoc LICENSE README
}

