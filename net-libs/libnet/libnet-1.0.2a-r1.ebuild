# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.0.2a-r1.ebuild,v 1.9 2003/04/17 22:41:57 sethbc Exp $

S=${WORKDIR}/Libnet-1.0.2a
DESCRIPTION="library to provide an API for commonly used low-level network
functions (mainly packet injection). Used by packet scrubbers and the like,
not to be confused with the perl libnet"
SRC_URI="http://www.packetfactory.net/libnet/dist/libnet.tar.gz"
HOMEPAGE="http://www.packetfactory.net/libnet/"
DEPEND=""

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc "

src_compile() {
	./configure	\
		--infodir=/usr/share/info	\
		--mandir=/usr/share/man	\
		--prefix=/usr	\
		--host=${CHOST}	|| die
	
	emake || die
}

src_install () {
	
	make 	\
		DESTDIR=${D}	\
		MAN_PREFIX=/usr/share/man	\
		install || die

	dodoc VERSION doc/{README,TODO*,CHANGELOG*,COPYING}
	newdoc README README.1st
	dodoc example/libnet*
	docinto Ancillary
	dodoc doc/Ancillary/*
}

