# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/linuxfromscratch-html/linuxfromscratch-html-3.3.ebuild,v 1.1 2002/04/09 20:59:56 spider Exp $

VER="3.3"

P="LFS-BOOK-3.3-HTML"
S=${WORKDIR}/${P}
DESCRIPTION="The Linux From Scratch Book. HTML Format"

SRC_URI="http://ftp.linuxfromscratch.org/lfs-books/${VER}/${P}.tar.bz2
ftp://ftp.planetmirror.com/pub/lfs/lfs-books/${VER}/${P}.tar.bz2
ftp://ftp.no.linuxfromscratch.org/mirrors/lfs/lfs-books/${VER}/${P}.tar.bz2
http://ftp.nl.linuxfromscratch.org/linux/lfs/lfs-books/${VER}/${P}.tar.bz2"

HOMEPAGE="http://www.linuxfromscratch.org"

src_install () {
	dodir /usr/share/doc/linuxfromscratch-html-${VER}
	cd ${S}
	cp -R * ${D}/usr/share/doc/linuxfromscratch-html-${VER}
}
