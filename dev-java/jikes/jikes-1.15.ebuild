# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Naresh Donti <ndonti@hotmail.com>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jikes/jikes-1.15.ebuild,v 1.1 2001/12/05 02:16:28 gbevin Exp $

A=jikes-1.15.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Jikes - IBM's open source, high performance java compiler"
SRC_URI="ftp://www-126.ibm.com/pub/jikes/${A}"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/jikes/"

DEPEND="virtual/glibc"

src_compile() {
    try ./configure --prefix=/usr/ --mandir=/usr/share/man --host=${CHOST}
    try make
}

src_install () {
    try make DESTDIR=${D} install
    dodoc ChangeLog COPYING AUTHORS README TODO NEWS
    mv ${D}/usr/doc/${P} ${D}/usr/share/doc/${PF}/html
    rm -rf ${D}/usr/doc
}
