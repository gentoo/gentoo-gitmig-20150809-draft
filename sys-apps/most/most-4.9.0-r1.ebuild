# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/most/most-4.9.0-r1.ebuild,v 1.5 2000/11/14 16:25:07 drobbins Exp $

P=most-4.9.0     
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An extremely excellent text file reader"
SRC_URI="ftp://space.mit.edu/pub/davis/most/${A}"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
	#*possible* (not definite) pmake problems, let's not risk it.
	try make 
}

src_install() {                               
	into /usr
	dobin src/objs/most
	doman most.1
	dodoc COPYING COPYRIGHT README changes.txt most-fun.txt
	dodoc default.rc lesskeys.rc
}


