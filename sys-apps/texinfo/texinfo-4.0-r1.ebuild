# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.0-r1.ebuild,v 1.5 2000/11/30 23:14:35 achim Exp $

P=texinfo-4.0      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GNU info program and utilities"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/texinfo/${A}
	 ftp://ftp.gnu.org/pub/gnu/texinfo/${A}"
DEPEND=">=sys-libs/gpm-1.19.3"
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr 
    try make ${MAKEOPTS}
}

src_install() {                               
    cd ${S}
    try make DESTDIR=${D} infodir=${D}/usr/info install
    cp ${O}/files/mkinfodir ${D}/usr/bin
    cd ${D}/usr/info
    mv texinfo texinfo.info
    for i in texinfo-*
    do 
	mv ${i} texinfo.info-${i#texinfo-*}
    done
    cd ${S}
    dodoc AUTHORS ChangeLog COPYING INTRODUCTION NEWS README TODO 
    docinto info
    dodoc info/README
    docinto makeinfo
    dodoc makeinfo/README
}






