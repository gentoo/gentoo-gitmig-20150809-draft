# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/enblend/enblend-4.0_rc3.ebuild,v 1.1 2009/12/05 17:45:51 maekke Exp $

EAPI=2

inherit eutils

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sourceforge.net/"
SRC_URI="mirror://sourceforge/enblend/${PN}-enfuse-${PV/_rc/RC}.tar.gz"

LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc gpu +image-cache +openexr openmp"

RDEPEND="
	media-libs/glew
	media-libs/jpeg
	media-libs/lcms
	media-libs/libpng
	media-libs/plotutils[X]
	media-libs/tiff
	gpu? ( virtual/glut )
	openexr? ( >=media-libs/openexr-1.0 )"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.31.0
	dev-util/pkgconfig
	doc? (
		media-gfx/transfig
		sci-visualization/gnuplot
		virtual/latex-base
	)"

S="${WORKDIR}/${PN}-enfuse-4.0RC3-3649376226b5"

pkg_setup() {
	if use image-cache && use openmp; then
		ewarn "the openmp and image-cache USE-flags are mutually exclusive"
		ewarn "image-cache will be disabled in favour of openmp"
	fi
}

src_configure() {
	local myconf=""
	if use image-cache && use openmp; then
		myconf="--disable-image-cache --enable-openmp"
	else
		myconf="$(use_enable image-cache) $(use_enable openmp)"
	fi

	use doc && myconf="${myconf} --with-gnuplot=$(type -p gnuplot)" \
		|| myconf="${myconf} --with-gnuplot=false"

	econf \
		--with-x \
		$(use_enable debug) \
		$(use_enable gpu gpu-support) \
		$(use_with openexr) \
		${myconf}
}

src_compile() {
	# forcing -j1 as every parallel compilation process needs about 1 GB RAM.
	emake -j1 || die
	if use doc; then
		cd doc
		make enblend.pdf enfuse.pdf || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
	use doc && dodoc doc/en{blend,fuse}.pdf
}
