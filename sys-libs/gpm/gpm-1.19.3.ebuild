# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.19.3.ebuild,v 1.3 2000/11/07 11:16:08 achim Exp $

P=gpm-1.19.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Console-based mouse driver"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/mouse/${A}"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/ncurses-5.1"

RDEPEND=$DEPEND

src_compile() { 
    cd ${S}                          
    try ./configure --prefix=/usr
    cp Makefile Makefile.orig
    sed -e "s/doc//" Makefile.orig > Makefile
    try make 
}

src_install() {                               
    into /usr
    dolib.a libgpm.a
    dolib.so libgpm.so.1.18.0
    dosym libgpm.so.1.18.0 /usr/lib/libgpm.so.1
    dosym libgpm.so.1.18.0 /usr/lib/libgpm.so
    dosbin gpm
    dobin disable-paste gpm-root mev
    insinto /usr/include
    doins gpm.h
    dodoc Announce COPYING ChangeLog FAQ MANIFEST README.* doc/gpmdoc.txt
    doinfo doc/gpm.info
    doman doc/*.1 doc/*.8 doc/*.7
}



