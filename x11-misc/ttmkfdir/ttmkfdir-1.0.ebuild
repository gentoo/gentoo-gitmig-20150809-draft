# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ttmkfdir/ttmkfdir-1.0.ebuild,v 1.3 2002/12/09 04:41:53 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A utility to create a fonts.scale file from a set of TrueType fonts"
SRC_URI="http://www.joerg-pommnitz.de/TrueType/ttmkfdir.tar.gz"
HOMEPAGE="http://www.joerg-pommnitz.de/TrueType/xfsft.html"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc  ppc"

DEPEND="<media-libs/freetype-2.0"

src_unpack() {
	mkdir ${P}
	cd ${P}
	unpack ${A}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	make clean || die
	make OPT="${CFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README
}
