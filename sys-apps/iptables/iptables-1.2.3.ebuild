# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iptables/iptables-1.2.3.ebuild,v 1.1 2001/09/06 20:21:09 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="http://netfilter.samba.org/${P}.tar.bz2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/g" -e "s:/usr/local:/usr:g" Makefile.orig > Makefile
}

src_compile() {
    #I had a problem with emake - DR
	make || die
}

src_install() {
	dodir /usr/lib /usr/share/man/man8 /usr/sbin
	make LIBDIR=${D}/usr/lib BINDIR=${D}/usr/sbin MANDIR=${D}/usr/share/man install || die
	dodoc COPYING KNOWN_BUGS
}
