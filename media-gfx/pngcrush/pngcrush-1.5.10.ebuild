# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.5.10.ebuild,v 1.13 2005/07/29 22:35:26 vanquirius Exp $

DESCRIPTION="PNG optimizing tool"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"
SRC_URI="mirror://sourceforge/pmt/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc"

DEPEND="virtual/libc"

src_compile() {
	cp Makefile.gcc Makefile
	emake CFLAGS="-I. ${CFLAGS}" || die
}

src_install() {
	dobin pngcrush
	use doc && dodoc {INSTALL,README}.txt
}
