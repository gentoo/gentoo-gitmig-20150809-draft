# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsvg/xsvg-0.1.2.ebuild,v 1.2 2004/03/26 21:25:24 twp Exp $

DESCRIPTION="X11 SVG viewer"
HOMEPAGE="http://xsvg.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/x11
	x11-libs/libsvg-cairo"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
}
