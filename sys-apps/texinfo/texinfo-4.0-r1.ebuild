# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.0-r1.ebuild,v 1.3 2000/09/15 20:09:23 drobbins Exp $

P=texinfo-4.0      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GNU info program and utilities"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/texinfo/${A}"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr --with-catgets
    try make
}

src_install() {                               
    cd ${S}
    try make prefix=${D}/usr install
    prepman
    prepinfo
    cp ${O}/files/mkinfodir ${D}/usr/bin
    dodoc AUTHORS COPYING INTRODUCTION NEWS README TODO 
}






