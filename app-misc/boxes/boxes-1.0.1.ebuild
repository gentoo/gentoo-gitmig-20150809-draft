# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/boxes/boxes-1.0.1.ebuild,v 1.6 2002/08/07 21:22:43 cselkirk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="boxes draws any kind of boxes around your text!"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/utils/text/${P}.src.tar.gz"
HOMEPAGE="http://www6.informatik.uni-erlangen.de/~tsjensen/boxes/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff
	cd src
}


src_compile() {
	make clean || die
	make CFLAGS="$CFLAGS -I. -Iregexp" || die
}

src_install() {
	dobin src/boxes
	doman doc/boxes.1
	dodoc README* COPYING 
	insinto /usr/share/boxes
	doins boxes-config
}
