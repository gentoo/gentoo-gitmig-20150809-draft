# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.8.0.ebuild,v 1.1 2001/07/30 14:58:41 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Package Config system that manages compile/link flags for libraries"
SRC_URI="http://www.freedesktop.org/software/pkgconfig/releases/${A}"
HOMEPAGE="http://www.freedesktop.org/software/pkgconfig/"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try pmake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README 
}

