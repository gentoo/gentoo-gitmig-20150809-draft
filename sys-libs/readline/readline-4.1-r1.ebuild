# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-4.1-r1.ebuild,v 1.3 2000/09/15 20:09:29 drobbins Exp $

P=readline-4.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Another cute console display library"
SRC_URI="ftp://ftp.gnu.org/gnu/readline/${A}"

src_compile() {                           
    try ./configure --host=${CHOST} --with-curses --prefix=/usr
    try make
    cd shlib
    try make
    cd ..

}

src_install() {                               
	cd ${S}
	try make prefix=${D}/usr install
	cd shlib
	try make prefix=${D}/usr install
	cd ..
	prepman
	prepinfo
	dodoc CHANGELOG CHANGES COPYING INSTALL MANIFEST README USAGE
	dodoc doc/*.ps
	docinto html
	dodoc doc/*.html
	dosym libhistory.so.4.1 /usr/lib/libhistory.so.4
	dosym libhistory.so.4.1 /usr/lib/libhistory.so
	dosym libreadline.so.4.1 /usr/lib/libreadline.so.4
	dosym libreadline.so.4.1 /usr/lib/libreadline.so
}



