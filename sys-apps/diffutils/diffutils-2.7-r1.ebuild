# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.7-r1.ebuild,v 1.5 2000/11/30 23:14:32 achim Exp $

P=diffutils-2.7      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/diffutils/${A}
	 ftp://ftp.gnu.org/gnu/diffutils/${A}"

HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
    try pmake
    makeinfo --html --force diff.texi
}

src_install() {                               
	into /usr
	doinfo *.info*
	dobin cmp diff diff3 sdiff
	dodoc COPYING ChangeLog NEWS README
	docinto html
	dodoc *.html
}


