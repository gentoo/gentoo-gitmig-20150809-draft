# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/diffutils/diffutils-2.7-r1.ebuild,v 1.1 2001/01/25 18:00:26 achim Exp $

P=diffutils-2.7      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/diffutils/${A}
	 ftp://ftp.gnu.org/gnu/diffutils/${A}"

HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr --disable-nls
    try pmake LDFLAGS=-static
}

src_install() {
	into /usr
	dobin cmp diff diff3 sdiff
}


