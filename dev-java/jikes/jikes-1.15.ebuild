# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Naresh Donti <ndonti@hotmail.com>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jikes/jikes-1.15.ebuild,v 1.2 2002/04/07 11:17:15 gbevin Exp $

A=jikes-1.15.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Jikes - IBM's open source, high performance java compiler"
SRC_URI="ftp://www-126.ibm.com/pub/jikes/${A}"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/jikes/"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	patch -p0 < ${FILESDIR}/jikes-1.15-gcc3.patch || die

}

src_compile() {
    ./configure --prefix=/usr/ --mandir=/usr/share/man --host=${CHOST} || die
    emake || die
}

src_install () {
    make DESTDIR=${D} install || die
    dodoc ChangeLog COPYING AUTHORS README TODO NEWS
    mv ${D}/usr/doc/${P} ${D}/usr/share/doc/${PF}/html
    rm -rf ${D}/usr/doc
}
