# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/enblend/enblend-2.1.ebuild,v 1.1 2005/02/24 04:02:01 lu_zero Exp $

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sf.net"
SRC_URI="mirror://sourceforge/enblend/${P}.tar.gz"
LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="media-libs/tiff
		>=dev-libs/boost-1.31.0"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO VIGRA_LICENSE
}
