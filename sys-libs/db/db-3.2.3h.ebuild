# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-3.2.3h.ebuild,v 1.3 2001/01/31 20:49:07 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}/build_unix
DESCRIPTION="Berkeley DB for transaction support in MySQL"
SRC_URI="ftp://mysql.valueclick.com/mysql/Downloads/db/${A}
	 http://download.sourceforge.net/pub/mirrors/mysql/Downloads/db/${A}"
HOMEPAGE="http://www.mysql.com"
RDEPEND="virtual/glibc"
DEPEND="$RDEPEND
	=sys-libs/db-1.85"
src_compile() {

    cd ${S}
    try ../dist/configure \
	--enable-compat185 --enable-dump185 \
	--prefix=/usr --host=${CHOST} \
	--enable-shared --enable-static \
	--enable-cxx 
	#--enable-rpc does not work

	echo
    # Parallel make does not work
    echo "Building static libs..."
    make libdb=libdb-3.2.a libdb-3.2.a
	make libcxx=libdb_cxx-3.2.a libdb_cxx-3.2.a

	echo
    echo "Building db_dump185..."
	try /bin/sh ./libtool --mode=compile cc -c ${CFLAGS} -I/usr/include/db1 -I../dist/../include -D_REENTRANT ../dist/../db_dump185/db_dump185.c
	try gcc -s -static -o db_dump185 db_dump185.lo -L/usr/lib -ldb1
	
	echo
	echo "Building everything else..."
	try make libdb=libdb-3.2.a libcxx=libdb_cxx-3.2.a 	
}

src_install () {
    cd ${S}
	try make libdb=libdb-3.2.a libcxx=libcxx_3.2.a prefix=${D}/usr install
    	dolib.a libdb-3.2.a libdb_cxx-3.2.a
	dolib libdb-3.2.la libdb_cxx-3.2.la
	cd ..
	dodoc README LICENSE
	mv ${D}/usr/docs ${D}/usr/doc/${PF}/html
	prepalldocs
	dodir usr/include/db3
	cd ${D}/usr/include
	mv *.h db3
	ln db3/db.h db.h
#	cd ${D}/usr/lib
#	ln -s libdb-3.2.a libdb.a
}

