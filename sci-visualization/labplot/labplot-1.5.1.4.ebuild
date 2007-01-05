# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/labplot/labplot-1.5.1.4.ebuild,v 1.2 2007/01/05 09:09:44 flameeyes Exp $

inherit eutils kde

PV_BUGFIX="${PV/?.?.?/}"
MY_PV="${PV/${PV_BUGFIX}/}"
MY_P="LabPlot-${MY_PV}"
S="${WORKDIR}/${MY_P}"

BUGFIX="LabPlot-${MY_PV}_${PV}.diff"

DESCRIPTION="LabPlot is a KDE application for data plotting and function analysis."
HOMEPAGE="http://labplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/labplot/${MY_P}.tar.gz"
[[ -n PV_BUGFIX ]] && SRC_URI="${SRC_URI} mirror://sourceforge/labplot/${BUGFIX}.gz"

LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="cdf fftw imagemagick jpeg2k kexi opengl tiff"

DEPEND=">=sci-libs/gsl-1.6
	sci-libs/netcdf
	virtual/ghostscript
	x11-libs/qwtplot3d
	media-libs/audiofile
	fftw? ( >=sci-libs/fftw-3 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )
	jpeg2k? ( >=media-libs/jasper-1.700.5-r1 )
	tiff? ( >=media-libs/tiff-3.5.5 )
	opengl? ( virtual/opengl )
	kexi? ( || ( app-office/kexi app-office/koffice ) )
	!amd64? ( cdf? ( sci-libs/cdf )
		>=media-gfx/pstoedit-3.33 )"
RDEPEND="${DEPEND}"
need-kde 3.4

[[ -n PV_BUGFIX ]] && PATCHES="${WORKDIR}/${BUGFIX}"

src_unpack() {
	kde_src_unpack
	# let's make sure we don't use included libs
	echo "# Using shared libs!" >| netcdf/netcdf.h
	echo "# Using shared libs!" >| qwtplot3d/qwt3d_plot.h
	echo "# Using shared libs!" >| audiofile/audiofile.h
}

src_compile() {
	export QTDIR="${ROOT}/usr/qt/3"
	export QWT3D_PATH="${ROOT}/usr"
	export KEXIDB_DIR="${ROOT}/usr"

	# texvc not in Portage and I'm not keen maintaining it
	# qsa ebuilds in bad shape atm.
	local myconf="--disable-fftw --enable-gsl --enable-ps2eps \
		--disable-texvc --disable-ocaml --enable-netcdf --enable-audiofile \
		--enable-system-qwtplot3d --enable-libundo --disable-qsa"

	if use amd64; then
		myconf="${myconf} --disable-cdf"
	else
		myconf="${myconf} $(use_enable cdf)"
	fi

	local myconf="${myconf} \
		$(use_enable fftw fftw3) \
		$(use_enable imagemagick ImageMagick) \
		$(use_enable jpeg2k jasper) \
		$(use_enable tiff) \
		$(use_enable kexi KexiDB) \
		$(use_enable opengl)"
	kde_src_compile
}

