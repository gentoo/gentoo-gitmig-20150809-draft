# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.53.ebuild,v 1.1 2002/04/27 13:32:34 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Excellent program which automatically configures your PPP session"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"
HOMEPAGE="http://http://open.nit.ca"

DEPEND="virtual/glibc
	net-libs/wvstreams"
	
RDEPEND="$DEPEND net-dialup/ppp"


src_compile() {
	
	cp Makefile Makefile.orig
	sed -e "s:PREFIX=/usr/local:PREFIX=/usr:" \
		Makefile.orig > Makefile
}

src_install() {
	cp Makefile Makefile.orig
	sed -e "s:PPPDIR=/etc/ppp/peers:PPPDIR=${D}/etc/ppp/peers:" \
		Makefile.orig > Makefile

	make \
		PREFIX=${D}/usr \
		install || die

	dodoc ANNOUNCE CHANGES COPYING.LIB README 
	dodoc debian/copyright debian/changelog
}
