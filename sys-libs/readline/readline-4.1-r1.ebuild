# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-4.1-r1.ebuild,v 1.9 2001/01/27 14:41:34 achim Exp $

P=readline-4.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Another cute console display library"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/readline/${A}
	 ftp://ftp.gnu.org/gnu/readline/${A}"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/ncurses-5.2"

RDEPEND=">=sys-libs/glibc-2.1.3"


src_compile() {                           
    try ./configure --host=${CHOST} --with-curses --prefix=/usr
    try make ${MAKEOPTS}
    cd shlib
    try make ${MAKEOPTS}

}


src_install() {                               
	cd ${S}
	try make prefix=${D}/usr install
	cd shlib
	try make prefix=${D}/usr install
	cd ..
	dodoc CHANGELOG CHANGES COPYING MANIFEST README USAGE
	docinto ps
	dodoc doc/*.ps
	docinto html
	dodoc doc/*.html
	mv ${D}/usr/lib ${D}
	dosym libhistory.so.4.1 /lib/libhistory.so
	dosym libreadline.so.4.1 /lib/libreadline.so
	# Needed because make install uses ${D} for the link
	dosym libhistory.so.4.1 /lib/libhistory.so.4
	dosym libreadline.so.4.1 /lib/libreadline.so.4
	chmod 755 ${D}/lib/*.4.1
}




