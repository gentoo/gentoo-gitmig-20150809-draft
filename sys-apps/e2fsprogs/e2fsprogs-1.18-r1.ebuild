# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/e2fsprogs/e2fsprogs-1.18-r1.ebuild,v 1.2 2000/08/16 04:38:24 drobbins Exp $
P=e2fsprogs-1.18      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard ext2 filesystem utilities"
SRC_URI="ftp://tsx-11.mit.edu/pub/linux/packages/ext2fs/e2fsprogs-1.18.tar.gz"
HOMEPAGE="http://web.mit.edu/tytso/www/linux/e2fsprogs.html"


src_compile() {                           
	./configure --host=${CHOST} --enable-elf-shlibs
	make
}

src_install() {                               
	into /usr
	make DESTDIR=${D} install
	make DESTDIR=${D} install-libs
	gzip -9 ${D}/usr/man/man?/*
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


