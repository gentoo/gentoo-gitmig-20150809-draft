# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.3.5-r1.ebuild,v 1.3 2000/09/15 20:09:26 drobbins Exp $

P=libtool-1.3.5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A shared library tool for developers"
SRC_URI="ftp://prep.ai.mit.edu/gnu/libtool/${A}"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"

src_compile() {
	try ./configure --prefix=/usr --host=${CHOST}
	try make
}

src_install() {                    
	into /usr
	dobin libtoolize libtool	
	insinto /usr/include
	doins libltdl/ltdl.h
	doinfo doc/libtool.info*
	cd libltdl/.libs
	insinto /usr/lib
	doins libltdl.a libltdl.la
	libopts -m0755
	dolib libltdl.so.0.1.2
	dosym libltdl.so.0.1.2 /usr/lib/libltdl.so.0
	dosym libltdl.so.0.1.2 /usr/lib/libltdl.so
	cd ${S}
	dodir /usr/share/aclocal
	insinto /usr/share/aclocal
	doins libtool.m4
	dodir /usr/share/libtool
	insinto /usr/share/libtool
	doins config.guess config.sub ltconfig ltmain.sh
	dodir /usr/share/libtool/libltdl
	insinto /usr/share/libtool/libltdl
	doins libltdl/*
	chmod 0755 ${D}/usr/share/libtool/libltdl/configure
	dodoc AUTHORS COPYING ChangeLog* NEWS README THANKS TODO doc/PLATFORMS	
}




