# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/debianutils/debianutils-1.13.3-r1.ebuild,v 1.3 2000/09/15 20:09:17 drobbins Exp $

P=debianutils-1.13.3     
A=debianutils_1.13.3.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A selection of tools from Debian"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/base/${A}"

src_compile() {                           
	try make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O2 -g/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
	into /
	dobin run-parts readlink tempfile mktemp 
	insopts -m755
	insinto /usr/sbin
	doins savelog
	doman run-parts.8 readlink.1 tempfile.1 mktemp.1 savelog.8
}



