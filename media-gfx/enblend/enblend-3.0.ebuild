# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/enblend/enblend-3.0.ebuild,v 1.8 2008/05/02 11:43:35 maekke Exp $

inherit eutils

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sourceforge.net/"
SRC_URI="mirror://sourceforge/enblend/${P}.tar.gz"

LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/tiff
	media-libs/lcms
	virtual/glut
	media-libs/glew
	media-libs/plotutils
	>=dev-libs/boost-1.31.0"

pkg_setup() {
	# bug 202476
	if ! built_with_use media-libs/plotutils X ; then
		eerror
		eerror "media-gfx/plotutils has to be built with USE=\"X\""
		eerror
		die "emerge plotutils with USE=\"X\""
	fi

	ewarn
	ewarn "The compilation of enblend needs a lot of RAM. If you have less"
	ewarn "than 1GB RAM (and swap) you probably won't be able to compile it."
	ewarn
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Both of the following patches can be found in the sf.net tracker
	# Fixes endless loop with seam optimizer and 360 deg images
	epatch "${FILESDIR}"/${P}-endless_loop_anneal.patch

	# Fixes compilation on AMD64
	epatch "${FILESDIR}"/${P}-amd64_compilation.patch

	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i '/CXXFLAGS/s: -g -O3 : :' src/Makefile.in
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
