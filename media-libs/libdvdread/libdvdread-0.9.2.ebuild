# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.2.ebuild,v 1.3 2001/11/14 03:47:13 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/libdvdread-${PV}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

DEPEND="virtual/glibc
	>=media-libs/libdvdcss-0.0.3"


src_compile() {

	./configure --prefix=/usr					\
	            --mandir=/usr/share/man				\
		    --infodir=/usr/share/info || die
	make || die
}

src_install() {
	
	make prefix=${D}/usr 						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

