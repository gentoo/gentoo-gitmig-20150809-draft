# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.0.2a-r1.ebuild,v 1.2 2002/07/11 06:30:47 drobbins Exp $

S=${WORKDIR}/Libnet-1.0.2a
DESCRIPTION="library to provide an API for commonly used low-level network
functions (mainly packet injection). Used by packet scrubbers and the like,
not to be confused with the perl libnet"
SRC_URI="http://www.packetfactory.net/libnet/dist/libnet.tar.gz"
HOMEPAGE="http://www.packefactory.net/libnet/"
DEPEND=""

#RDEPEND=""

src_compile() {
	./configure	\
		--infodir=/usr/share/info	\
		--mandir=/usr/share/man	\
		--prefix=/usr	\
		--host=${CHOST}	|| die
	
	emake || die
}

src_install () {
	
	# try make prefix=${D}/usr install

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

