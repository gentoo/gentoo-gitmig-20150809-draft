# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bison/bison-1.28-r1.ebuild,v 1.3 2000/09/15 20:09:25 drobbins Exp $

P=bison-1.28      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A yacc-compatible parser generator"
SRC_URI="ftp://prep.ai.mit.edu/gnu/bison/${A}"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install() {                               
    cd ${S}
    try make prefix=${D}/usr install
    dodoc COPYING AUTHORS NEWS ChangeLog README REFERENCES OChangeLog doc/FAQ
    prepman
    prepinfo
}


