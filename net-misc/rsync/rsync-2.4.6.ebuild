# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.4.6.ebuild,v 1.1 2000/10/05 18:22:51 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="File transfer program to keep remote files into sync"
SRC_URI="http://rsync.samba.org/ftp/rsync/${A}"
HOMEPAGE="http://rsync.samba.org"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --sysconfdir=/etc/rsync --host=${CHOST} 
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    prepman
    dodir /etc/rsync
    dodoc COPYING README

}


