# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/bison/bison-1.28-r1.ebuild,v 1.1 2001/01/27 22:04:24 achim Exp $

P=bison-1.28      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A yacc-compatible parser generator"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/bison/${A}
	 ftp://prep.ai.mit.edu/gnu/bison/${A}"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"
DEPEND="virtual/glibc"
src_compile() {                           
    try ./configure --prefix=/usr --datadir=/usr/share/bison --host=${CHOST} --disable-nls
    try make ${MAKEOPTS} LDFLAGS=-static
}

src_install() {
    cd ${S}
    try make prefix=${D}/usr datadir=${D}/usr/share/bison install
    rm -rf ${D}/usr/man ${D}/usr/info
}


