# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/enblend/enblend-3.0.ebuild,v 1.2 2007/08/25 12:45:34 vapier Exp $

inherit eutils

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sourceforge.net/"
SRC_URI="mirror://sourceforge/enblend/${P}.tar.gz"

LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/tiff
	media-libs/lcms
	virtual/glut
	media-libs/glew
	media-libs/plotutils
	>=dev-libs/boost-1.31.0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Both of the following patches can be found in the sf.net tracker
	# Fixes endless loop with seam optimizer and 360 deg images
	epatch "${FILESDIR}"/${P}-endless_loop_anneal.patch

	# Fixes compilation on AMD64
	epatch "${FILESDIR}"/${P}-amd64_compilation.patch

	sed -i '/CXXFLAGS/s: -g -O3 : :' src/Makefile.in
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
