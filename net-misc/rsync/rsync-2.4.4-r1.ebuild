# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.4.4-r1.ebuild,v 1.2 2000/08/16 04:38:20 drobbins Exp $

P=rsync-2.4.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="File transfer program to keep remote files into sync"
SRC_URI="ftp://rsync.samba.org/pub/rsync/${A}"
HOMEPAGE="http://rsync.samba.org"


src_compile() {

    cd ${S}
    ./configure --prefix=/usr --sysconfdir=/etc/rsync --host=${CHOST} 
    make

}

src_install () {

    cd ${S}
    make prefix=${D}/usr install
    prepman
    dodir /etc/rsync
    dodoc COPYING README

}


