# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.3.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/libdvdread-${PV}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"
SLOT="0"

DEPEND="virtual/glibc
	>=media-libs/libdvdcss-1.1.1"


src_compile() {

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die

	make || die
}

src_install() {
	
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

