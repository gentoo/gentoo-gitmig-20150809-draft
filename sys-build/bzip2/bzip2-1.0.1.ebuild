# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/bzip2/bzip2-1.0.1.ebuild,v 1.1 2001/01/25 18:00:26 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A high-quality data compressor used extensively by Gentoo"
SRC_URI="ftp://sourceware.cygnus.com/pub/bzip2/v100/${A}
	 ftp://ftp.freesoftware.com/pub/sourceware/bzip2/v100/${A}"

HOMEPAGE="http://sourceware.cygnus.com/bzip2/"


src_unpack() {
    unpack ${A}
    # bzip2's try makefile does not use CFLAGS so we hard-wire the compile
    # options using sed ;)
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {
	try pmake LDFLAGS=-static all
}
src_install() {
        into /
        dobin bzip2
        cd ${D}/bin
        ln bzip2 bunzip2
}


