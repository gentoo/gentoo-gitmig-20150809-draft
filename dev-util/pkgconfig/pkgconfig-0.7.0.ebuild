# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.7.0.ebuild,v 1.1 2001/06/21 17:49:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Package Config utility used by DirectFB"
SRC_URI="http://www.directfb.org/download/contrib/${A}"
HOMEPAGE="http://"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README 
}

