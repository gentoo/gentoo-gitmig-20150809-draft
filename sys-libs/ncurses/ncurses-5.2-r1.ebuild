# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.2-r1.ebuild,v 1.2 2001/01/22 04:26:51 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/ncurses/${A}
	 ftp://ftp.gnu.org/pub/gnu/ncurses/${A}"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {  
	try ./configure --prefix=/usr --libdir=/lib \
		--enable-symlinks --disable-termcap \
		--with-shared --with-libtool \
		--without-debug --with-rcs-ids \
		--host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() {                               
	try make DESTDIR=${D} install 
	cd ${D}/lib
	ln -s libncurses.a libcurses.a
	chmod 755 ${D}/lib/*.5.0.2
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

	#with this fix, the default xterm has color as it should
	cd ${D}/usr/share/terminfo/x
	mv xterm xterm.orig
	ln -s xterm-color xterm
}



