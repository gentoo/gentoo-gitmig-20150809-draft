# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ttf2pt1/ttf2pt1-3.3.3.ebuild,v 1.7 2002/08/02 17:42:50 phoenix Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Converts True Type to Type 1 fonts"
SRC_URI="http://download.sourceforge.net/ttf2pt1/${P}.tgz"
HOMEPAGE="http://ttf2pt1.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"

RDEPEND="virtual/glibc
	>=media-libs/freetype-2.0"
DEPEND="$RDEPEND sys-devel/perl"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff
}

src_compile() {

	make CFLAGS="${CFLAGS}" all || die

}

src_install () {

	make INSTDIR=${D}/usr install || die
	dodir /usr/share/doc/${PF}/html
	cd ${D}/usr/share/ttf2pt1
	rm -r app other
	mv *.html ../doc/${PF}/html
	mv [A-Z]* ../doc/${PF}
	prepalldocs 
}
