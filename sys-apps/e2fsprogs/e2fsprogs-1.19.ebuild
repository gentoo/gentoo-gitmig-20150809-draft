# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/e2fsprogs/e2fsprogs-1.19.ebuild,v 1.3 2000/09/15 20:09:17 drobbins Exp $

P=e2fsprogs-1.19
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard ext2 filesystem utilities"
SRC_URI="ftp://download.sourceforge.net/pub/sourceforge/e2fsprogs/e2fsprogs-1.19.tar.gz"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"


src_compile() {                           
	try ./configure --host=${CHOST} --enable-elf-shlibs
	try make
}

src_install() {                               
	into /usr
	try make DESTDIR=${D} install
	try make DESTDIR=${D} install-libs
	prepman
	if [ -z "DBUG" ]
	then
		strip ${D}/sbin/*
		strip ${D}/usr/sbin/*
		strip ${D}/usr/bin/*
		strip --strip-unneeded ${D}/lib/*.so*
		strip --strip-unneeded ${D}/usr/lib/*.so*
	fi
	dodoc COPYING ChangeLog README RELEASE-NOTES 
}



