# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ronald Moesbergen <r.moesbergen@hccnet.nl>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Decodes MS-TNEF MIME attachments"
SRC_URI="http://world.std.com/~damned/${A}"
HOMEPAGE="http://world.std.com/~damned/software.html"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {

    cd ${S}
    ./configure --prefix=/usr --host=${CHOST}
    emake || die

}

src_install () {

    cd ${S}
    make DESTDIR=${D} install || die
    dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO
    doman doc/tnef.1
}


