# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/labplot/labplot-1.3.0.ebuild,v 1.4 2005/01/05 14:44:59 phosphan Exp $

inherit eutils gnuconfig kde

MPN="LabPlot"

DESCRIPTION="KDE application for plotting and analysis of 2d and 3d functions and data"
HOMEPAGE="http://labplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MPN}-${PV}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="fftw imagemagick tiff"

MAKEOPTS="${MAKEOPTS} -j1"

DEPEND=">=sci-libs/gsl-1.3
	fftw? ( >=sci-libs/fftw-2.1.5 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )
	x86? ( >=media-gfx/pstoedit-3.33 )
	tiff? ( >=media-libs/tiff-3.5.5 )
	>=media-libs/jasper-1.700.5-r1"

need-kde 3.1

S="${WORKDIR}/${MPN}-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	local myconf="\
		$(use_enable fftw) \
		$(use_enable fftw fftw3) \
		$(use_enable imagemagick ImageMagick) \
		$(use_enable tiff)"
	gnuconfig_update
	kde_src_compile
}
