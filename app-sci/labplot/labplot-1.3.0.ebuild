# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/labplot/labplot-1.3.0.ebuild,v 1.1 2004/07/27 02:58:00 ribosome Exp $

inherit kde

MPN="LabPlot"

DESCRIPTION="KDE application for plotting and analysis of 2d and 3d functions and data"
HOMEPAGE="http://labplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MPN}-${PV}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86"
SLOT="0"
IUSE="fftw imagemagick tiff"

MAKEOPTS="${MAKEOPTS} -j1"

DEPEND=">=dev-libs/gsl-1.3
	fftw? ( >=dev-libs/fftw-2.1.5 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )
	x86? ( >=media-gfx/pstoedit-3.33 )
	tiff? ( >=media-libs/tiff-3.5.5 )
	>=media-libs/jasper-1.700.5-r1"

need-kde 3.1

S="${WORKDIR}/${MPN}-${PV}"

src_compile() {
	local myconf="\
		$(use_enable fftw) \
		$(use_enable fftw fftw3) \
		$(use_enable imagemagick ImageMagick) \
		$(use_enable tiff)"
	# Uncomment the following for use on amd64.
	# if [ ${ARCH} = "amd64" ]; then
	# 	myconf="${myconf} \
	# 	--host=x86-linux-gnu \
	# 	--build=x86-linux-gnu \
	# 	--disable-pstoedit"
	# fi
	kde_src_compile
}
