# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iptables/iptables-1.2.2.ebuild,v 1.1 2001/05/09 11:09:31 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="http://netfilter.samba.org/${A}"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/g" -e "s:/usr/local:/usr:g" Makefile.orig > Makefile
}

src_compile() {
    #I had a problem with pmake - DR
	try make
}


src_install() {
	dodir /usr/lib /usr/share/man/man8 /usr/sbin
	try make LIBDIR=${D}/usr/lib BINDIR=${D}/usr/sbin MANDIR=${D}/usr/share/man install
	dodoc COPYING KNOWN_BUGS
}


