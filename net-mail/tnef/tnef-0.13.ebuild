# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/tnef/tnef-0.13.ebuild,v 1.2 2000/11/01 04:44:20 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Decodes MS-TNEF MIME attachments"
SRC_URI="http://world.std.com/~damned/${A}"
HOMEPAGE="http://world.std.com/~damned/software.html"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO

}


