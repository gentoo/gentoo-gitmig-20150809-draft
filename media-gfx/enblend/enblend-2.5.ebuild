# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/enblend/enblend-2.5.ebuild,v 1.2 2006/04/18 01:39:41 halcy0n Exp $

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sf.net"
SRC_URI="mirror://sourceforge/enblend/${P}.tar.gz"
LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/tiff
		>=dev-libs/boost-1.31.0"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
