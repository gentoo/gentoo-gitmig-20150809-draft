# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.3.14-r1.ebuild,v 1.3 2000/09/15 20:09:20 drobbins Exp $

P=modutils-2.3.14
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard kernel module utilities"
SRC_URI="ftp://ftp.ocs.com.au/pub/modutils/v2.3/${A}"

src_compile() {                           
	try ./configure --prefix=/ --host=${CHOST}
	try make
}

src_install() {                               
	cd ${S}
	dodir /sbin 
	dodir /usr/man/man1
	dodir /usr/man/man8
	dodir /usr/man/man5
	dodir /usr/man/man2
	try make prefix=${D} mandir=${D}/usr/man install
	prepman
	strip ${D}/sbin/*
	dodoc COPYING CREDITS ChangeLog NEWS README TODO
}




