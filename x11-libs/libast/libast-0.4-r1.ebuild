# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.4-r1.ebuild,v 1.10 2003/03/20 12:57:30 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="LIBrary of Assorted Spiffy Things.  Needed for Eterm."
HOMEPAGE="http://www.eterm.org/download"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha ~mips ~hppa ~arm"

DEPEND="virtual/x11
	>=media-libs/freetype-1.3"

src_compile() {
	# always disable mmx because binutils-2.11.92+ seems to be broken for this package
	myconf="--disable-mmx"
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README
}
