# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/boxes/boxes-1.0.1.ebuild,v 1.13 2004/02/29 17:19:59 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="boxes draws any kind of boxes around your text!"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/utils/text/${P}.src.tar.gz"
HOMEPAGE="http://www6.informatik.uni-erlangen.de/~tsjensen/boxes/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
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
