# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.3.5-r2.ebuild,v 1.1 2001/02/07 16:07:39 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/libtool/${A}
	 ftp://prep.ai.mit.edu/gnu/libtool/${A}"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

DEPEND="virtual/glibc"

src_compile() {
	try ./configure --prefix=/usr --infodir=/usr/share/info --host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() { 
	try make DESTDIR=${D} install                   
	dodoc AUTHORS COPYING ChangeLog* NEWS \
	      README THANKS TODO doc/PLATFORMS	
}




