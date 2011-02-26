# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/flam3/flam3-2.7.18-r1.ebuild,v 1.4 2011/02/26 17:10:21 signals Exp $

EAPI=2

DESCRIPTION="Tools and a library for creating flame fractal images"
HOMEPAGE="http://flam3.com/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/libxml2
	media-libs/libpng
	virtual/jpeg
	!<=x11-misc/electricsheep-2.6.8-r2"

src_prepare() {
	sed -i \
		-e '/^Requires/s:libpng12:libpng:' \
		flam3.pc.in || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.txt *.flam3 || die
}
