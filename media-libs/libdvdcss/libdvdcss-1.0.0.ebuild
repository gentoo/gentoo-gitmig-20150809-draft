# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdcss/libdvdcss-1.0.0.ebuild,v 1.1 2001/11/13 21:08:01 azarah Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A portable abstraction library for DVD decryption"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.videolan.org/libdvdcss/"

DEPEND="virtual/glibc"


src_compile() {

	./configure --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info ||die
		    
	make || die
}

src_install() {
	
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

