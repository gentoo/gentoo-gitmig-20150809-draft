# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Converts Bitmaps to vector-grahics"
SRC_URI="http://prdownloads.sourceforge.net/autotrace/autotrace-${PV}.tar.gz"
HOMEPAGE="http://autotrace.sourceforge.net/"

DEPEND="virtual/glibc
	>=x11-libs/gtkDPS-0.3.3
	>=x11-libs/gtk+-1.2.10-r4"


src_compile() {

	./configure --host=${CHOST}				\
		    --prefix=/usr || die
		    
#	cp Makefile Makefile.orig
#	sed -e "s:\$(LINK):\$(LINK) -lXt:" Makefile.orig > Makefile

	make || die
}

src_install() {

	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING ChangeLog NEWS README 
}

