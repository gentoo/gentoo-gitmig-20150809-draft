# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/labplot/labplot-1.5.0.5.ebuild,v 1.3 2006/04/30 14:02:25 carlo Exp $

inherit eutils gnuconfig kde

MY_P="LabPlot-${PV/_/.}"
S="${WORKDIR}/${MY_P%.?}"

DESCRIPTION="KDE application for plotting and analysis of 2d and 3d functions and data"
HOMEPAGE="http://labplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/labplot/${MY_P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="cdf fftw imagemagick jpeg2k kexi opengl tiff"

DEPEND=">=sci-libs/gsl-1.4
	sci-libs/netcdf
	virtual/ghostscript
	>=x11-libs/qwtplot3d-0.2.6-r2
	media-libs/audiofile
	fftw? ( >=sci-libs/fftw-3 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )
	jpeg2k? ( >=media-libs/jasper-1.700.5-r1 )
	tiff? ( >=media-libs/tiff-3.5.5 )
	opengl? ( virtual/opengl )
	kexi? ( || ( app-office/kexi app-office/koffice ) )
	!amd64? ( cdf? ( sci-libs/cdf )
		>=media-gfx/pstoedit-3.33 )"

need-kde 3.4

src_unpack() {
	kde_src_unpack
	sed -e "s:QWT3D_PATH/include:QWT3D_PATH/include/qwtplot3d:" \
		-e "s:KEXIDB_DIR/include:KEXIDB_DIR/include/kexidb:" \
		-i configure
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
		--enable-system-qwtplot3d --disable-qsa"

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
	gnuconfig_update
	kde_src_compile
}

