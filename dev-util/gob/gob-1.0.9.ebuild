# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-util/gob/gob-1.0.9.ebuild,v 1.1 2001/06/05 19:43:20 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GOB is a preprocessor for making GTK+ objects with inline C code"
SRC_URI="http://ftp.5z.com/pub/gob/${A}"
HOMEPAGE="http://www.5z.com/jirka/gob.html"

DEPEND=">=dev-libs/glib-1.2.10 sys-devel/flex"
RDEPEND=">=dev-libs/glib-1.2.10"
src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING CHangeLog NEWS README TODO

}

