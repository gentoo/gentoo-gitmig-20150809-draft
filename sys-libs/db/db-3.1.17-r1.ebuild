# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-3.1.17-r1.ebuild,v 1.1 2000/11/17 01:50:35 drobbins Exp $

A=${P}-patched.tar.gz
S=${WORKDIR}/${P}-patched/build_unix
DESCRIPTION="Berkeley DB for transaction support in MySQL"
SRC_URI="ftp://mysql.valueclick.com/mysql/Downloads/db/${A}
	 http://download.sourceforge.net/pub/mirrors/mysql/Downloads/db/${A}"
HOMEPAGE="http://www.mysql.com"
DEPEND=">=sys-libs/glibc-2.2 !sys-libs/glibc-2.1.3 =sys-libs/db-1.8.5"

src_compile() {

    cd ${S}
    try ../dist/configure --enable-compat185 --enable-dump185 --prefix=/usr --host=${CHOST} --enable-shared --enable-static --enable-rpc --enable-cxx

	echo
    echo "Building static libs..."
    make libdb=libdb-3.1.a libdb-3.1.a
	make libcxx=libdb_cxx-3.1.a libdb_cxx-3.1.a

	echo
    echo "Building db_dump185..."
	try /bin/sh ./libtool --mode=compile cc -c ${CFLAGS} -I/usr/include/db1 -I../dist/../include -D_REENTRANT ../dist/../db_dump185/db_dump185.c
	try gcc -s -static -o db_dump185 db_dump185.lo -L/usr/lib -ldb1
	
	echo
	echo "Building everything else..."
	try make libdb=libdb-3.1.a libcxx=libdb_cxx-3.1.a LDFLAGS="-s"	
}

src_install () {
    cd ${S}
	try make libdb=libdb-3.1.a libcxx=libcxx_3.1.a prefix=${D}/usr install
    dolib.a libdb-3.1.a libdb_cxx-3.1.a
	dolib libdb-3.1.la libdb_cxx-3.1.la
	cd ..
	dodoc README LICENSE
	mv ${D}/usr/docs ${D}/usr/doc/${PF}/html
	dodir usr/include/db3
	cd ${D}/usr/include
	mv *.h db3
}

