# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/mergetrees/mergetrees-0.9.3.ebuild,v 1.2 2001/11/10 12:45:09 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A three-way directory merge tool"
SRC_URI="http://cvs.bofh.asn.au/mergetrees/${P}.tar.gz"
HOMEPAGE="http://cvs.bofh.asn.au/mergetrees/"

RDEPEND="virtual/glibc
	>=sys-devel/perl-5
	>=sys-apps/diffutils-2"

src_compile() {                           
	./configure --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info
	assert

	make clean || die
	emake || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die
	
	dodoc AUTHORS COPYING Changelog NEWS README* TODO
}
