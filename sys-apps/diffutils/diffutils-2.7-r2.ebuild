# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.7-r2.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/diffutils/${A}
	 ftp://ftp.gnu.org/gnu/diffutils/${A}"

HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
DEPEND="virtual/glibc"

src_compile() {

    try ./configure --host=${CHOST} --prefix=/usr
    try pmake

}

src_install() {
	
	doinfo *.info*
	dobin cmp diff diff3 sdiff

	dodoc COPYING ChangeLog NEWS README
}


