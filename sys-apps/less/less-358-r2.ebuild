# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-358-r2.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Excellent text file viewer"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/less/${A}
	 ftp://ftp.gnu.org/pub/gnu/less/${A}"
HOMEPAGE="http://www.gnu.org/software/less/less.html"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_compile() {

    try ./configure --host=${CHOST} --prefix=/usr
    try pmake

}

src_install() {

	dobin less lessecho lesskey

	newman lesskey.nro lesskey.1
	newman less.nro less.1

	dodoc COPYING NEWS README LICENSE 
}



