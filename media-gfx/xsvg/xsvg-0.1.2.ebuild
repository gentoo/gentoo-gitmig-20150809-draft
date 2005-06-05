# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsvg/xsvg-0.1.2.ebuild,v 1.8 2005/06/05 12:25:07 hansmi Exp $

DESCRIPTION="X11 SVG viewer"
HOMEPAGE="http://xsvg.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
DEPEND="virtual/x11
	x11-libs/libsvg-cairo"

src_install() {
	make install DESTDIR=${D} || die
}
