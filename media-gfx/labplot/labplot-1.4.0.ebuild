# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/labplot/labplot-1.4.0.ebuild,v 1.1 2005/01/05 14:44:59 phosphan Exp $

inherit eutils gnuconfig kde

MPN="LabPlot"

DESCRIPTION="KDE application for plotting and analysis of 2d and 3d functions and data"
HOMEPAGE="http://labplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MPN}-${PV}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="arts fftw imagemagick tiff audiofile cdf netcdf"

MAKEOPTS="${MAKEOPTS} -j1"

DEPEND=">=sci-libs/gsl-1.3
	fftw? ( >=sci-libs/fftw-3 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )
	x86? ( >=media-gfx/pstoedit-3.33 )
	audiofile? ( media-libs/audiofile )
	tiff? ( >=media-libs/tiff-3.5.5 )
	>=media-libs/jasper-1.700.5-r1
	netcdf? ( sci-libs/netcdf )
	!amd64? ( cdf? ( sci-libs/cdf ) )
	>=sys-apps/sed-4"

need-kde 3.1

S="${WORKDIR}/${MPN}-${PV}"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/getversion.patch
	local cdfversion=\"$(cdfinquire -id | grep "CDF dist" | \
						cut -f 2 -d "V" | tr -d " \n")\"
	sed -e "s~CDF_VERSION~${cdfversion}~" -i src/LabPlotDialog.cc || \
		die "sed failed on CDF_VERSION"
}

src_compile() {
	local myconf
	if use amd64; then
		myconf="$(use_enable cdf)"
	else
		myconf="--disable-cdf"
	fi

	local myconf="${myconf} \
		--disable-fftw \
		$(use_enable fftw fftw3) \
		$(use_enable imagemagick ImageMagick) \
		$(use_enable audiofile) \
		$(use_with arts) \
		$(use_enable tiff) \
		$(use_enable netcdf)"
	gnuconfig_update
	kde_src_compile
}

