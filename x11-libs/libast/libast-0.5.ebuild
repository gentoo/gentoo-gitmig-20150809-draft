# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.5.ebuild,v 1.4 2003/03/03 09:31:29 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="LIBrary of Assorted Spiffy Things.  Needed for Eterm."
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"
HOMEPAGE="http://www.eterm.org/download/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha ~sparc"
IUSE="pic imlib"

DEPEND="virtual/glibc
	virtual/x11
	>=media-libs/freetype-1.3"

src_compile() {
	# always disable mmx because binutils-2.11.92+ seems to be broken for this package
	local myconf="--disable-mmx --with-gnu-ld --with-x"
	use pic && myconf="${myconf} --with-pic"
	use imlib && myconf="${myconf} --with-imlib"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
