# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.4-r1.ebuild,v 1.3 2000/09/15 20:08:46 drobbins Exp $

P=sash-3.4    
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A small UNIX Shell"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/"${A}
HOMEPAGE="http://www.canb.auug.org.au/~dbell/"

src_compile() {                           
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O3:${CFLAGS}:" Makefile.orig > Makefile
	try make
}

src_install() {                               
	cd ${S}
	into /
	dobin sash
	into /usr
	doman sash.1
	dodoc README

}





