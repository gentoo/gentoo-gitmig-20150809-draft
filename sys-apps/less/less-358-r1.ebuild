# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-358-r1.ebuild,v 1.5 2000/10/09 16:02:50 achim Exp $

P=less-358
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Excellent text file viewer"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/less/${A}
	 ftp://ftp.gnu.org/pub/gnu/less/${A}"
HOMEPAGE="http://www.gnu.org/software/less/less.html"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
    try make
}

src_install() {                               
	cd ${S}
	into /usr
	dobin less lessecho lesskey
	cp lesskey.nro lesskey.1
	cp less.nro less.1
	doman *.1
	rm *.1
	dodoc COPYING NEWS README LICENSE less.hlp
}



