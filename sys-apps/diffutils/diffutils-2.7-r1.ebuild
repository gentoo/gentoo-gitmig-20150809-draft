# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.7-r1.ebuild,v 1.3 2000/09/15 20:09:17 drobbins Exp $

P=diffutils-2.7      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://ftp.gnu.org/gnu/diffutils/diffutils-2.7.tar.gz"
HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
    try make
}

src_install() {                               
	into /usr
	doinfo *.info*
	dobin cmp diff diff3 sdiff
	dodoc COPYING ChangeLog NEWS README
}


