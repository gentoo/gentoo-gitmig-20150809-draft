# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/debianutils/debianutils-1.13.3-r1.ebuild,v 1.1 2001/01/25 18:00:26 achim Exp $

P=debianutils-1.13.3     
A=debianutils_1.13.3.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A selection of tools from Debian"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/base/${A}"

src_compile() {                           
	try pmake LDFLAGS=-static
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O2 -g/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {

	into /
	dobin readlink tempfile mktemp

}



