# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gdl/gdl-0.9.ebuild,v 1.1 2010/12/21 19:52:08 bicatali Exp $

EAPI="2"

WX_GTK_VER="2.8"

inherit autotools eutils wxwidgets

DESCRIPTION="An Interactive Data Language compatible incremental compiler"
HOMEPAGE="http://gnudatalanguage.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnudatalanguage/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fftw grib hdf hdf5 imagemagick netcdf openmp python udunits wxwidgets X"

RDEPEND="sys-libs/readline
	sys-libs/ncurses
	sci-libs/gsl
	sci-libs/plplot
	fftw? ( >=sci-libs/fftw-3 )
	grib? ( sci-libs/grib_api )
	hdf? ( sci-libs/hdf )
	hdf5? ( sci-libs/hdf5 )
	imagemagick? ( media-gfx/imagemagick )
	netcdf? ( sci-libs/netcdf )
	python? ( dev-python/matplotlib )
	udunits? ( >=sci-libs/udunits-2 )
	wxwidgets? ( x11-libs/wxGTK:2.8[X] )"

DEPEND="${RDEPEND}
	dev-java/antlr[cxx]"

pkg_setup() {
	use wxwidgets && wxwidgets_pkg_setup
}

src_prepare() {
	use hdf5 && has_version sci-libs/hdf5[mpi] && export CXX=mpicxx
	epatch \
		"${FILESDIR}"/${PN}-0.9_rc4-antlr.patch \
		"${FILESDIR}"/${PN}-0.9_rc2-gcc4.4.patch \
		"${FILESDIR}"/${PN}-0.9_rc4-gcc4.3.patch \
		"${FILESDIR}"/${PN}-0.9-numpy.patch \
		"${FILESDIR}"/${PN}-0.9-configure.patch

	# we need to blow away the directory with antlr
	# otherwise the build system picks up bogus
	# header files
	rm -fr "${S}"/src/antlr || die "failed to remove antlr directory"

	# adjust the *.pro file install path
	sed -i -e "s:datasubdir=.*$:datasubdir=\"${PN}\":" configure.in \
		|| die "Failed to fix *.pro install patch."

	sed -i -e "s:ANTLR_LIB:-lantlr:" src/Makefile.am \
		|| die "Failed to adjust link to libantlr."
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable python python_module) \
		$(use_with X x) \
		$(use_with fftw) \
		$(use_with grib) \
		$(use_with hdf) \
		$(use_with hdf5) \
		$(use_with netcdf) \
		$(use_with imagemagick Magick) \
		$(use_with openmp) \
		$(use_with udunits) \
		$(use_with wxwidgets wxWidgets)
}

src_test() {
	cd "${S}"/testsuite
	echo ".r test_suite" | ../src/gdl
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README PYTHON.txt AUTHORS ChangeLog NEWS TODO HACKING
}
