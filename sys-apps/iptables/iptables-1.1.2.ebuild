# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iptables/iptables-1.1.2.ebuild,v 1.1 2000/11/05 02:52:16 drobbins Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="http://netfilter.kernelnotes.org/${A}"

src_compile() {                           
    try make
}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/g" -e "s:/usr/local:/usr:g" Makefile.orig > Makefile
}

src_install() {
	dodir /usr/lib /usr/man/man8 /usr/bin
	try make LIBDIR=${D}/usr/lib BINDIR=${D}/usr/bin MANDIR=${D}/usr/man install
	dodoc COPYING KNOWN_BUGS
}


