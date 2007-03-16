# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsvg/xsvg-0.2.1.ebuild,v 1.8 2007/03/16 18:48:53 nixnut Exp $

inherit autotools eutils

DESCRIPTION="Command line usable X11 SVG viewer"
HOMEPAGE="http://cairographics.org"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""
RDEPEND=">=x11-libs/libsvg-cairo-0.1.6"
DEPEND="${RDEPEND}
	x11-libs/libXt
	x11-libs/libXcursor"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
