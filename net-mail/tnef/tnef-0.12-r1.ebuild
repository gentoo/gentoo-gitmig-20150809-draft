# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/tnef/tnef-0.12-r1.ebuild,v 1.1 2000/08/08 20:58:39 achim Exp $

P=tnef-0.12
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="net-mail"
DESCRIPTION="Decodes MS-TNEF MIME attachments"
SRC_URI="http://world.std.com/~damned/${A}"
HOMEPAGE="http://world.std.com/~damned/software.html"


src_compile() {

    cd ${S}
    ./configure --prefix=/usr --host=${CHOST}
    make

}

src_install () {

    cd ${S}
    make DESTDIR=${D} install
    dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO

}


