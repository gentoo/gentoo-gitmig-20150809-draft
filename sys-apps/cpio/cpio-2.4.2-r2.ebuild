# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpio/cpio-2.4.2-r2.ebuild,v 1.1 2001/01/01 21:57:38 drobbins Exp $

P="cpio-2.4.2"      
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="A file archival tool which can also read and write tar files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/cpio/${A}
	 ftp://prep.ai.mit.edu/gnu/cpio/${A}"

HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
	try ./configure --host=${CHOST} --prefix=/usr
	try pmake
	makeinfo --html --force cpio.texi
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
	#dobin cpio mt; now we're using Schilly's enhanced mt from star
	dobin cpio
	doman cpio.1
	doinfo cpio.info
	dodoc COPYING* ChangeLog NEWS README
	docinto html
	dodoc cpio.html

}

