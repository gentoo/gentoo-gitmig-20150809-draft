# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpio/cpio-2.4.2-r1.ebuild,v 1.3 2000/09/15 20:09:17 drobbins Exp $

P="cpio-2.4.2"      
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="A file archival tool which can also read and write tar files"
SRC_URI="ftp://prep.ai.mit.edu/gnu/cpio/"${A}
HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"

src_compile() {                           
	try ./configure --host=${CHOST} --prefix=/usr
	try make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv rmt.c rmt.c.orig
    sed -e "78d" rmt.c.orig > rmt.c
    mv userspec.c userspec.c.orig
    sed -e "85d" userspec.c.orig > userspec.c
}

src_install() {                               
	into /usr
	dobin cpio mt
	doman cpio.1 mt.1
	doinfo cpio.info
	dodoc COPYING* ChangeLog NEWS README
}

