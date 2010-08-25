# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gdl/gdl-0.9_rc4.ebuild,v 1.7 2010/08/25 16:21:38 xarthisius Exp $

EAPI="2"

WX_GTK_VER="2.8"

inherit autotools eutils flag-o-matic multilib wxwidgets

MYP=${P/_/}
DESCRIPTION="An Interactive Data Language compatible incremental compiler"
HOMEPAGE="http://gnudatalanguage.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnudatalanguage/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fftw hdf hdf5 imagemagick netcdf openmp udunits wxwidgets X"

RDEPEND="
	>=sys-libs/readline-4.3
	sci-libs/gsl
	=dev-java/antlr-2.7*[cxx]
	>sci-libs/plplot-5.9
	fftw? ( >=sci-libs/fftw-3 )
	hdf? ( sci-libs/hdf )
	hdf5? ( sci-libs/hdf5 )
	imagemagick? ( || ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] ) )
	netcdf? ( sci-libs/netcdf )
	udunits? ( sci-libs/udunits )
	wxwidgets? ( x11-libs/wxGTK:2.8[X] )"
#	python? ( dev-python/numarray dev-python/matplotlib )
DEPEND="${RDEPEND}
	sys-devel/libtool"

S="${WORKDIR}/${MYP}"

pkg_setup() {
	use wxwidgets && wxwidgets_pkg_setup
}

src_prepare() {
	use hdf5 && has_version sci-libs/hdf5[mpi] && export CXX=mpicxx
	epatch "${FILESDIR}"/${PN}-0.9_rc2-gcc4.4.patch \
		"${FILESDIR}"/${P}-gcc4.3.patch \
		"${FILESDIR}"/${P}-antlr.patch \
		"${FILESDIR}"/${P}-wxwidgets.patch \
		"${FILESDIR}"/${P}-gcc4.5.patch

	# we need to blow away the directory with antlr
	# otherwise the build system picks up bogus
	# header files
	rm -fr "${S}"/src/antlr || die "failed to remove antlr directory"

	# adjust the *.pro file install path
	sed -i -e "s:datasubdir=.*$:datasubdir=\"${PN}\":" configure.in \
		|| die "Failed to fix *.pro install patch."

	# set path to libantlr. Note that we need to explicitly link against
	# libantlr.a since kde-sdk provides libantlr.so which we can not
	# use (see bug #286630).
	sed -i -e "s:ANTLR_LIB:/usr/$(get_libdir)/libantlr.a:" src/Makefile.am \
		|| die "Failed to adjust link to libantlr."
	eautoreconf
}

src_configure() {
	# make sure we're hdf5-1.6 backward compatible
	use hdf5 && append-flags -DH5_USE_16_API

#Remove Python support until upstream uses numpy instead of numarray
#	  $(use_with python) \
	econf \
		--with-python=no \
		$(use_with X x) \
		$(use_with fftw) \
		$(use_with hdf) \
		$(use_with hdf5) \
		$(use_with netcdf) \
		$(use_with imagemagick Magick) \
		$(use_with openmp) \
		$(use_with udunits) \
		$(use_with wxwidgets wxWidgets) \
		${myconf}
}

src_test() {
	cd "${S}"/testsuite
	PATH="${S}"/src gdl <<-EOF
		test_suite
	EOF
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README PYTHON.txt AUTHORS ChangeLog NEWS TODO HACKING \
		|| die "Failed to install docs"
}
