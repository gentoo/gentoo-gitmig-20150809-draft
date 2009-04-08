# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/labplot/labplot-1.6.0.2.ebuild,v 1.2 2009/04/08 07:52:54 bicatali Exp $

EAPI=1
inherit eutils kde multilib

MY_P="LabPlot-${PV}"

DESCRIPTION="KDE application for data plotting and function analysis."
HOMEPAGE="http://labplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="audiofile bindist cdf fftw hdf5 gsl imagemagick jpeg2k kexi
	netcdf opengl qhull R tiff"

RDEPEND="media-gfx/pstoedit
	>=sci-libs/liborigin-20080225:0
	virtual/ghostscript
	gsl? ( bindist? ( <sci-libs/gsl-1.10 ) !bindist? ( sci-libs/gsl ) )
	audiofile? ( media-libs/audiofile )
	fftw? ( >=sci-libs/fftw-3 )
	imagemagick? ( media-gfx/imagemagick )
	jpeg2k? ( media-libs/jasper )
	tiff? ( media-libs/tiff )
	opengl? ( virtual/opengl x11-libs/qwtplot3d-qt3 )
	kexi? ( || ( app-office/kexi app-office/koffice ) )
	cdf? ( sci-libs/cdf )
	netcdf? ( sci-libs/netcdf )
	hdf5? ( sci-libs/hdf5 )
	qhull? ( media-libs/qhull )
	R? ( dev-lang/R )"

DEPEND="${RDEPEND}"
PATCHES="${FILESDIR}/${PN}-1.6.0.1-linkexec.patch
	${FILESDIR}/${PN}-1.6.0.1-desktop.patch
	${FILESDIR}/${PN}-1.6.0.1-audiofile.patch
	${FILESDIR}/${PN}-1.6.0.1-liborigin.patch
	${FILESDIR}/${P}-gcc43.patch"

need-kde 3.5

S="${WORKDIR}/${MY_P}"

src_unpack() {
	kde_src_unpack

	cd "${S}"

	# let's make sure we don't use included libs
	echo "# Using shared libs!" >| netcdf/netcdf.h
	echo "# Using shared libs!" >| qwtplot3d/qwt3d_plot.h
	echo "# Using shared libs!" >| liborigin*/OPJFile.h

	# sed for qwtplot3d, qt3 version (gentoo-specific)
	# (should be gone when labplot using qt4)
	sed -i \
		-e 's:-lqwtplot3d:-lqwtplot3d-qt3:g' \
		-e 's:include/qwtplot3d:include/qwtplot3d-qt3:g' \
		-e 's:AC_CHECK_LIB(qwtplot3d,:AC_CHECK_LIB(qwtplot3d-qt3,:' \
		configure || die
}

src_compile() {
	export QTDIR="/usr/qt/3"
	export QWT3D_PATH="/usr"
	export KEXIDB_DIR="/usr"
	use R && export R_HOME=/usr/$(get_libdir)/R

	# reasons for disabling options:
	# - fftw is fftw2, so we prefer fftw3
	# - texvc external would need mediawiki (big), internal conflicts with it
	# - ocaml: only used to compile internal texvc
	# - qsa in portage tree is too buggy
	# file a bug if you have workarounds
	local myconf="
		--disable-fftw
		--disable-texvc
		--disable-ocaml
		--disable-qsa
		--enable-ps2eps
		--enable-system-liborigin
		$(use_enable audiofile)
		$(use_enable fftw fftw3)
		$(use_enable gsl)
		$(use_enable imagemagick ImageMagick)
		$(use_enable jpeg2k jasper)
		$(use_enable tiff)
		$(use_enable kexi KexiDB)
		$(use_enable cdf)
		$(use_enable hdf5)
		$(use_enable netcdf)
		$(use_enable netcdf system-netcdf)
		$(use_enable opengl gl)
		$(use_enable opengl system-qwtplot3d)
		$(use_enable qhull)
		$(use_enable R)"

	kde_src_compile
}

src_install() {
	kde_src_install
	dodoc BUGS* WISHLIST CHANGES FEATURES \
		TIPS PLAN CREDITS || die
}
