# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/make/make-3.79.1-r1.ebuild,v 1.1 2000/08/03 14:16:17 achim Exp $

P=make-3.79.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard tool to compile source trees"
CATEGORY="sys-devel"
SRC_URI="ftp://prep.ai.mit.edu/gnu/make/${P}"
HOMEPAGE="http://www.gnu.org/software/make/make.html"

src_compile() {                           
	./configure --prefix=/usr --host=${CHOST}
	sh ./build.sh
}

src_unpack() {
    unpack ${A}
    cd ${S}
}

src_install() {                               
	into /usr
	dobin make
	doman make.1
	doinfo make.info*
	dodoc AUTHORS COPYING ChangeLog NEWS README* 
}



