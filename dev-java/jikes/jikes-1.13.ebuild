# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

A=jikes-1.13.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Jikes - IBM's open source, high performance java compiler"
SRC_URI="http://oss.software.ibm.com/pub/jikes/${A}"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/jikes/"

src_compile() {
    try ./configure --prefix=/usr/ --mandir=/usr/share/man --host=${CHOST}
    try make
}

src_install () {
    try make DESTDIR=${D} install
    dodoc ChangeLog COPYING AUTHORS README TODO NEWS
    mv ${D}/usr/doc/jikes-1.13 ${D}/usr/share/doc/${PF}/html
    rm -rf ${D}/usr/doc
}
