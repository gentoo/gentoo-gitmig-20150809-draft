# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.0.2a.ebuild,v 1.1 2001/08/16 04:15:22 lamer Exp $

S=${WORKDIR}/Libnet-1.0.2a
DESCRIPTION="library to provide an API for commonly used low-level network
functions (mainly packet injection). Used by packet scrubbers and the like,
not to be confused with the perl libnet"
SRC_URI="http://www.packetfactory.net/libnet/dist/libnet.tar.gz"
HOMEPAGE="http://www.packefactory.net/libnet/"
DEPEND=""

#RDEPEND=""

src_compile() {
	try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
	
	try emake
	#try make
}

src_install () {
	
	# try make prefix=${D}/usr install

    try make DESTDIR=${D} MAN_DIR=${D}/usr/share/man install
	 dodoc VERSION doc/{README,TODO*,CHANGELOG*,COPYING}
	 newdoc README README.1st
	 dodoc example/libnet*
	 docinto Ancillary
	 dodoc doc/Ancillary/*
}

