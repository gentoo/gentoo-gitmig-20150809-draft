# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.7-r1.ebuild,v 1.2 2000/08/16 04:38:24 drobbins Exp $

P=diffutils-2.7      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://ftp.gnu.org/gnu/diffutils/diffutils-2.7.tar.gz"
HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"

src_compile() {                           
    ./configure --host=${CHOST} --prefix=/usr
    make
}

src_install() {                               
	into /usr
	doinfo *.info*
	dobin cmp diff diff3 sdiff
	dodoc COPYING ChangeLog NEWS README
}


