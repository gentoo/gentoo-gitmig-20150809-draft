# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.4-r1.ebuild,v 1.2 2001/11/24 18:40:50 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://prep.ai.mit.edu/gnu/libtool/${A}"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/1.4/libtool.m4.patch
}

src_compile() {
	try ./configure --prefix=/usr --infodir=/usr/share/info --host=${CHOST}
	try pmake
}

src_install() { 
	try make DESTDIR=${D} install                   
	dodoc AUTHORS COPYING ChangeLog* NEWS \
	      README THANKS TODO doc/PLATFORMS	
}




