# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/db/db-1.86.4.ebuild,v 1.1 2000/11/17 01:03:07 drobbins Exp $

A=db.1.86.tar.gz
S=${WORKDIR}/db.1.86
DESCRIPTION="db 1.86 -- required for RPM 4.0 to compile; that's about it."
SRC_URI="http://www.sleepycat.com/update/1.86/db.1.86.tar.gz"
HOMEPAGE="http://www.slpeeycat.com"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/Makefile ${S}/PORT/linux
	cp ${FILESDIR}/bt_split.c ${S}/btree
	cp ${FILESDIR}/bt_page.c ${S}/btree
}

src_compile() {

    cd ${S}/PORT/linux
    try make OORG=\"${CFLAGS} -fomit-frame-pointer\" prefix=/usr

}

src_install () {

    cd ${S}/PORT/linux
    dodir /usr/lib
    dodir /usr/include
    try make prefix=${D}/usr install

}


