# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.2-r3.ebuild,v 1.2 2001/04/23 04:17:55 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/ncurses/${A}
	 ftp://ftp.gnu.org/pub/gnu/ncurses/${A}"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
DEPEND="virtual/glibc"

src_compile() {

    if [ -z "$DEBUG" ]
    then
      myconf="${myconf} --without-debug"
    fi
	try ./configure --prefix=/usr --libdir=/lib --mandir=/usr/share/man \
		--enable-symlinks --enable-termcap \
		--with-shared --with-rcs-ids \
		--host=${CHOST}  ${myconf}

	try make ${MAKEOPTS}

}

src_install() {

        dodir /usr/lib
	try make DESTDIR=${D} install

	cd ${D}/lib
	ln -s libncurses.a libcurses.a
	chmod 755 ${D}/lib/*.${PV}
        dodir /usr/lib
        mv libform* libmenu* libpanel* ../usr/lib
        mv *.a ../usr/lib

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



