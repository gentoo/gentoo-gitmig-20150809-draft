# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="treewm is a WindowManager that arranges the windows in a tree not a list"
SRC_URI="mirror://sourceforge/treewm/${PN}_${PV}.tar.bz2"
HOMEPAGE="http://treewm.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc 
 	virtual/x11"
RDEPEND=${DEPEND}

src_compile() {
	cd treewm
	cp Makefile Makefile.orig
	sed -e "s:PREFIX  = /usr/X11R6:PREFIX  = ${D}/usr:" \
	    Makefile.orig > Makefile
	cd ..
	emake || die
}

src_install() {
	dodir /usr
	dodir /usr/pixmaps
	dobin treewm/treewm

	make install || die

	dodoc ChangeLog README AUTHORS default.cfg sample.cfg TODO README.tiling PROBLEMS
}
