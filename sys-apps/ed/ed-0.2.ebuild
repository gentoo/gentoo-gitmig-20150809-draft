#!/usr/bin/ebuild
# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2.ebuild,v 1.4 2000/10/09 16:02:50 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Your basic line editor"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/ed/${A}
	 ftp://ftp.gnu.org/pub/gnu/ed/${A}"
HOMEPAGE="http://www.gnu.org/software/ed/"

src_compile() {                           
	try ./configure --prefix=/ --host=${CHOST}
	try make
}

src_install() {                               
	try make prefix=${D}/ mandir=${D}/usr/man/man1 infodir=${D}/usr/info install
	prepman
	prepinfo
	dodoc COPYING ChangeLog NEWS POSIX README THANKS TODO
}


