# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.5-r1.ebuild,v 1.4 2003/11/14 15:14:12 vapier Exp $

DESCRIPTION="LIBrary of Assorted Spiffy Things"
HOMEPAGE="http://www.eterm.org/download/"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc alpha ~mips hppa ~arm"
IUSE="imlib"

DEPEND="virtual/x11
	>=media-libs/freetype-1.3
	imlib? ( media-libs/imlib )"

src_compile() {
	# always disable mmx because binutils-2.11.92+ seems to be broken for this package
	local myconf="--disable-mmx --with-gnu-ld --with-x"
	use imlib && myconf="${myconf} --with-imlib"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
