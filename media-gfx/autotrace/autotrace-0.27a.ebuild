# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.27a.ebuild,v 1.5 2002/07/11 06:30:27 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Converts Bitmaps to vector-grahics"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://autotrace.sourceforge.net/"

DEPEND="virtual/glibc
	>=x11-libs/gtkDPS-0.3.3
	=x11-libs/gtk+-1.2*"


src_compile() {

	./configure --host=${CHOST} \
		--prefix=/usr || die
		    
	#	cp Makefile Makefile.orig
	#	sed -e "s:\$(LINK):\$(LINK) -lXt:" Makefile.orig > Makefile

	make || die
}

src_install() {

	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING ChangeLog NEWS README 
}

