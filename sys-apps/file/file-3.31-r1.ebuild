# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-3.31-r1.ebuild,v 1.2 2000/08/16 04:38:24 drobbins Exp $

P=file-3.31
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Program to identify a file's format by scanning binary data for patters"
SRC_URI="ftp://ftp.astron.com/pub/file/file-3.31.tar.gz"

src_compile() {                           
    ./configure --prefix=/usr --host=${CHOST}
    make
}

src_install() {                               
	into /usr
	dobin file
	doman file.1 magic.4
	dodir /usr/share
	insinto /usr/share
	doins magic magic.mime
	dodoc LEGAL.NOTICE MAINT README
}



