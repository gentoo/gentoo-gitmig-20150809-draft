# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/labplot/labplot-1.5.1.6-r1.ebuild,v 1.2 2008/02/08 19:00:49 bicatali Exp $

inherit eutils kde

PV_BUGFIX="${PV/?.?.?/}"
MY_PV="${PV%${PV_BUGFIX}}"
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
IUSE="bindist cdf fftw imagemagick jpeg2k kexi opengl tiff"

DEPEND="bindist? ( <sci-libs/gsl-1.10 )
	!bindist? ( sci-libs/gsl )
	media-gfx/pstoedit
	sci-libs/netcdf
	sci-libs/liborigin
	virtual/ghostscript
	x11-libs/qwtplot3d-qt3
	media-libs/audiofile
	fftw? ( >=sci-libs/fftw-3 )
	imagemagick? ( media-gfx/imagemagick )
	jpeg2k? ( media-libs/jasper )
	tiff? ( media-libs/tiff )
	opengl? ( virtual/opengl )
	kexi? ( || ( app-office/kexi app-office/koffice ) )
	cdf? ( sci-libs/cdf )"

RDEPEND="${DEPEND}"

need-kde 3.5

[[ -n PV_BUGFIX ]] && PATCHES="${WORKDIR}/${BUGFIX}"

src_unpack() {
	kde_src_unpack

	# let's make sure we don't use included libs
	echo "# Using shared libs!" >| netcdf/netcdf.h
	echo "# Using shared libs!" >| qwtplot3d/qwt3d_plot.h
	echo "# Using shared libs!" >| audiofile/audiofile.h

	# sed for qwtplot3d, qt3 version (gentoo-specific)
	# (gone in versions > 2.0, with qt4)
	sed -i \
		-e 's:-lqwtplot3d:-lqwtplot3d-qt3:g' \
		-e 's:include/qwtplot3d:include/qwtplot3d-qt3:g' \
		-e 's:AC_CHECK_LIB(qwtplot3d,:AC_CHECK_LIB(qwtplot3d-qt3,:' \
		configure configure.in || die
}

src_compile() {
	export QTDIR="/usr/qt/3"
	export QWT3D_PATH="/usr"
	export KEXIDB_DIR="/usr"

	# texvc not in Portage and I'm not keen maintaining it
	# qsa ebuilds in bad shape atm.
	local myconf="--disable-fftw --enable-gsl --enable-ps2eps \
		--disable-texvc --disable-ocaml --enable-netcdf --enable-audiofile \
		--enable-system-qwtplot3d --enable-libundo --disable-qsa"

	myconf="${myconf} \
		$(use_enable fftw fftw3) \
		$(use_enable imagemagick ImageMagick) \
		$(use_enable jpeg2k jasper) \
		$(use_enable tiff) \
		$(use_enable kexi KexiDB) \
		$(use_enable opengl) \
		$(use_enable cdf)"
	kde_src_compile
}
