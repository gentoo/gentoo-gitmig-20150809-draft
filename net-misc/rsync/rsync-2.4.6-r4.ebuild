# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.4.6-r4.ebuild,v 1.2 2001/08/04 18:22:45 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="File transfer program to keep remote files into sync"
SRC_URI="http://rsync.samba.org/ftp/rsync/${A}"
HOMEPAGE="http://rsync.samba.org"

DEPEND="virtual/glibc"

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

    try ./configure --prefix=/usr --host=${CHOST} 
    if [ "`use static`" ] ; then
	try make LDFLAGS=\"-static\"
    else
        try make
    fi

}

src_install () {
	
	try make prefix=${D}/usr mandir=${D}/usr/share/man install 
	if [ -z "`use build`" ] && [ -z "`use bootcd`" ] ; then
        dodir /etc/rsync
        dodoc COPYING README
    else
        rm -rf ${D}/usr/share
    fi

}


