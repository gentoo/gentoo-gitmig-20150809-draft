# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libflash/libflash-0.4.10.ebuild,v 1.1 2001/06/21 17:03:23 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A library for flash animations"
SRC_URI="http://www.directfb.org/download/contrib/${A}"
HOMEPAGE="http://"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README
}

