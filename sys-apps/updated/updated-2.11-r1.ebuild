# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/updated/updated-2.11-r1.ebuild,v 1.2 2000/08/16 04:38:31 drobbins Exp $

P=updated-2.11
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Update flushes filesystem buffers at regular intervals"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${P}"

src_compile() {                           
	make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O3/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
	into /
	dosbin update
	doman update.8
	dodoc COPYING update.lsm debian/*
}


