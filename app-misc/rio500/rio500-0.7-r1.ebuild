# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/rio500/rio500-0.7-r1.ebuild,v 1.3 2002/04/27 07:31:38 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Command line tools for transfering mp3s to and from a Rio500"
SRC_URI="http://download.sourceforge.net/rio500/${P}.tar.gz"
HOMEPAGE="http://rio500.sourceforge.net"

DEPEND="virtual/glibc
	=dev-libs/glib-1.2*"

src_compile() {
	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--with-fontpath=/usr/share/rio500/ \
		--with-id3support || die
#		--with-usbdevfs
	make || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share/rio500 \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO 
	dodoc fonts/Readme.txt
}
