# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bison/bison-1.28-r1.ebuild,v 1.9 2001/02/01 19:30:33 achim Exp $

P=bison-1.28      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A yacc-compatible parser generator"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/bison/${A}
	 ftp://prep.ai.mit.edu/gnu/bison/${A}"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"

PROVIDE="virtual/bison"
DEPEND="virtual/glibc"

src_compile() {                           
    try ./configure --prefix=/usr --datadir=/usr/share/bison --host=${CHOST}
    try make ${MAKEOPTS}
}

src_install() {                               
    cd ${S}
    try make prefix=${D}/usr datadir=${D}/usr/share/bison install
    dodoc COPYING AUTHORS NEWS ChangeLog README REFERENCES OChangeLog 
    docinto txt
    dodoc doc/FAQ
}


