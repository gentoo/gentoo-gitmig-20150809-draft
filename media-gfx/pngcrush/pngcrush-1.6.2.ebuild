# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.6.2.ebuild,v 1.2 2006/02/22 19:47:21 dertobi123 Exp $

DESCRIPTION="PNG optimizing tool"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"
SRC_URI="mirror://sourceforge/pmt/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc-macos ~x86"
IUSE="doc"

DEPEND="virtual/libc"

src_compile() {
	emake CFLAGS="-I. ${CFLAGS}" || die
}

src_install() {
	dobin pngcrush
	use doc && dodoc {INSTALL,README}.txt
}
