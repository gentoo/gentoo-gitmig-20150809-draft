# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-tools/console-tools-0.2.3-r1.ebuild,v 1.3 2000/09/15 20:09:17 drobbins Exp $

P=console-tools-0.2.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Console and font utilities"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/keyboards/"${A}
HOMEPAGE="http://altern.org/ydirson/en/lct/"

src_compile() {                           
	try ./configure --prefix=/usr --host=${CHOST}
	mv Makefile Makefile.orig
	#building without documentation for now
	sed -e s/doc// Makefile.orig > Makefile
	try make all
}

src_install() {    
	into /usr
	cd ${S}
	try make DESTDIR=${D} install
	strip ${D}/usr/bin/*
	strip --strip-unneeded ${D}/usr/lib/*.so.0.0.0
	dodoc BUGS COPYING* CREDITS ChangeLog NEWS README RELEASE TODO
	gzip -9 ${D}/usr/man/man8/*.8
	MOPREFIX="console-tools"
	domo ${S}/po/*.gmo
}


