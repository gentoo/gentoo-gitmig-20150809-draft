# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/rio500/rio500-0.7.ebuild,v 1.2 2001/04/25 21:17:20 michael Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Command line tools for transfering mp3s to and from a Rio500"
SRC_URI="http://download.sourceforge.net/rio500/${A}"
HOMEPAGE="http://rio500.sourceforge.net"

DEPEND="virtual/glibc
	>=dev-libs/glib-1.2.9"

src_compile() {
    try ./configure --prefix=/usr --host=${CHOST} \
         --with-fontpath=/usr/share/rio500 
#         --with-usbdevfs --with-id3support
    try make
}

src_install () {
    try make prefix=${D}/usr mandir=${D}/usr/share/man \
             datadir=${D}/usr/share/rio500  install

    dodoc AUTHORS COPYING ChangeLog NEWS README TODO 
    dodoc fonts/Readme.txt
}

