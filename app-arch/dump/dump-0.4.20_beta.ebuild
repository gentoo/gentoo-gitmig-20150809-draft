# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.20_beta.ebuild,v 1.1 2000/11/19 12:08:48 achim Exp $

P=dump-0.4b20
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
SRC_URI="http://download.sourceforge.net/dump/${A}"
HOMEPAGE="http://dump.sourceforge.net"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    dodir /sbin
    dodir /usr/man/man8
    dodir /etc/dumpdates
    try make BINDIR=${D}/sbin MANDIR=${D}/usr/man/man8 \
	DUMPDATESPATH=${D}/etc/dumpdates install

}

