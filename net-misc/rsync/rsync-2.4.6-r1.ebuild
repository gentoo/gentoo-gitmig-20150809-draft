# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.4.6-r1.ebuild,v 1.1 2000/12/21 03:28:40 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="File transfer program to keep remote files into sync"
SRC_URI="http://rsync.samba.org/ftp/rsync/${A}"
HOMEPAGE="http://rsync.samba.org"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
#change confdir to /etc/rsync rather than just /etc (the --sysconfdir configure option doesn't work
	cp rsync.h rsync.h.orig
	sed -e 's:RSYNCD_CONF "/etc/rsyncd.conf":RSYNCD_CONF "/etc/rsync/rsyncd.conf":g' rsync.h.orig > rsync.h
#yes, updating the man page is very important.
	cp rsyncd.conf.5 rsyncd.conf.5.orig
	sed -e 's:/etc/rsyncd:/etc/rsync/rsyncd:g' rsyncd.conf.5.orig > rsyncd.conf.5
} 

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} 
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    prepman
    dodir /etc/rsync
    dodoc COPYING README

}


