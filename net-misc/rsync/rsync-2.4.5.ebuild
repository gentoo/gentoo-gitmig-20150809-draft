# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.4.5.ebuild,v 1.2 2000/09/15 20:09:13 drobbins Exp $

P=rsync-2.4.5
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


