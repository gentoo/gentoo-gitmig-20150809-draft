# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.1-r1.ebuild,v 1.8 2000/11/12 21:35:07 achim Exp $

P=ncurses-5.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/ncurses/${A}
	 ftp://ftp.gnu.org/pub/gnu/ncurses/${A}"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"

src_compile() {  
	#export CFLAGS="-V 2.95.2 ${CFLAGS}"
	#export CXXFLAGS=$CFLAGS
	try ./configure --prefix=/usr --enable-symlinks --disable-termcap \
	--with-gpm --with-shared --without-debug --with-rcs-ids --host=${CHOST}
	try make
}

src_install() {                               
	try make prefix=${D}/usr install
	#move to root so that we can use ncurses on boot
	cd ${D}/usr/lib
	dodir /lib
	mv *.so* ../../lib
        preplib /
	cd ${S}
	dodoc ANNOUNCE MANIFEST NEWS README* TO-DO 
	dodoc doc/*.doc
	docinto html
	dodoc doc/html/*.html
	docinto html/ada
	dodoc doc/html/ada/*.htm
	docinto html/ada/files
	dodoc doc/html/ada/files/*.htm
	docinto html/ada/funcs
	dodoc doc/html/ada/funcs/*.htm
	docinto html/man
	dodoc doc/html/man/*.html
	gzip ${D}/usr/man/man1/tack.1
}



