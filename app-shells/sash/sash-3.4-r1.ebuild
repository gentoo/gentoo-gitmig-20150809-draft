# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.4-r1.ebuild,v 1.1 2000/08/13 12:10:49 achim Exp $

P=sash-3.4    
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A small UNIX Shell"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/"${A}
HOMEPAGE="http://www.canb.auug.org.au/~dbell/"
CATEGORY="app-shells"

src_compile() {                           
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O3:${CFLAGS}:" Makefile.orig > Makefile
	make
}

src_install() {                               
	cd ${S}
	into /
	dobin sash
	into /usr
	doman sash.1
	dodoc README

}





