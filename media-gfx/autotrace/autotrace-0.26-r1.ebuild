# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.26-r1.ebuild,v 1.2 2002/04/28 04:50:25 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Converts Bitmaps to vector-grahics"
SRC_URI="http://homepages.go.com/homepages/m/a/r/martweb/${P}.tar.gz"
HOMEPAGE="http://homepages.go.com/homepages/m/a/r/martweb/AutoTrace.htm"

DEPEND="virtual/glibc
	>=x11-libs/gtkDPS-0.3.3
	>=x11-libs/gtk+-1.2.10-r4"


src_compile() {

	./configure --prefix=/usr || die
	#	cp Makefile Makefile.orig
	#	sed -e "s:\$(LINK):\$(LINK) -lXt:" Makefile.orig > Makefile
	make || die

}

src_install () {

	cd ${S}
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README 
}
