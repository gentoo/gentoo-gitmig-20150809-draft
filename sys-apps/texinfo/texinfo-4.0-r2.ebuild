# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.0-r2.ebuild,v 1.1 2001/02/07 15:51:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GNU info program and utilities"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/texinfo/${A}
	 ftp://ftp.gnu.org/pub/gnu/texinfo/${A}"

DEPEND=">=sys-libs/ncurses-5.2-r2
        >=sys-devel/gettext-0.10.35-r2"

RDEPEND=">=sys-libs/ncurses-5.2-r2"

src_compile() {

    try ./configure --host=${CHOST} --prefix=/usr  --mandir=/usr/share/man --infodir=/usr/share/info
    try make ${MAKEOPTS} 
}

src_install() {

    try make DESTDIR=${D} infodir=${D}/usr/share/info install
    exeinto /usr/sbin
    doexe ${FILESDIR}/mkinfodir

    cd ${D}/usr/share/info
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






