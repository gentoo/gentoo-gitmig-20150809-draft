# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.5.4-r1.ebuild,v 1.2 2000/08/16 04:38:34 drobbins Exp $

P=patch-2.5.4      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utility to apply diffs to files"
SRC_URI="ftp://ftp.gnu.org/gnu/patch/${A}"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"

src_compile() {                           
	./configure --host=${CHOST} --prefix=/usr
	make
}

src_install() {                               
	into /usr
	dobin patch
	cp patch.man patch.1
	doman patch.1
	dodoc AUTHORS COPYING ChangeLog NEWS README
}



