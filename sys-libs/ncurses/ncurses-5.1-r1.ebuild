# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.1-r1.ebuild,v 1.2 2000/08/16 04:38:36 drobbins Exp $

P=ncurses-5.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/ncurses/${A}"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"

src_compile() {                           
	./configure --prefix=/usr --enable-symlinks --disable-termcap \
	--with-gpm --with-shared --without-debug --with-rcs-ids --host=${CHOST}
	make
}

src_install() {                               
	make prefix=${D}/usr install

	if [ -z "$DBUG" ]
	then
		strip --strip-unneeded ${D}/usr/lib/*.so.5.1
		strip ${D}/usr/bin/*
	fi

	#move to root so that we can use ncurses on boot
	cd ${D}/usr/lib
	dodir /lib
	mv *.so* ../../lib
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



