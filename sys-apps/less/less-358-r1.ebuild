# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-358-r1.ebuild,v 1.6 2000/11/30 23:14:33 achim Exp $

P=less-358
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Excellent text file viewer"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/less/${A}
	 ftp://ftp.gnu.org/pub/gnu/less/${A}"
HOMEPAGE="http://www.gnu.org/software/less/less.html"

DEPEND=">=sys-libs/gpm-1.19.3"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
    try pmake
}

src_install() {                               
	cd ${S}
	into /usr
	dobin less lessecho lesskey
	cp lesskey.nro lesskey.1
	cp less.nro less.1
	doman *.1
	dodoc COPYING NEWS README LICENSE 
}



