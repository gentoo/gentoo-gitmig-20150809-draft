# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gdl/gdl-0.9-r1.ebuild,v 1.1 2011/01/04 05:04:15 bicatali Exp $

EAPI=3

WX_GTK_VER="2.8"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"

inherit autotools eutils wxwidgets python

RESTRICT_PYTHON_ABIS="3.*"

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
	dev-java/antlr"

pkg_setup() {
	use wxwidgets && wxwidgets_pkg_setup
}

src_prepare() {
	use hdf5 && has_version sci-libs/hdf5[mpi] && export CXX=mpicxx

	epatch \
		"${FILESDIR}"/${PN}-0.9_rc2-gcc4.4.patch \
		"${FILESDIR}"/${PN}-0.9_rc4-gcc4.3.patch \
		"${FILESDIR}"/${PN}-0.9-numpy.patch \
		"${FILESDIR}"/${PN}-0.9-configure.patch

	# adjust the *.pro file install path
	sed -i \
		-e "s:datasubdir=.*$:datasubdir=\"${PN}\":" \
		configure.in || die "Failed to fix *.pro install patch."
	eautoreconf
	use python && python_copy_sources
}

src_configure() {
	configuration() {
		econf \
			$(use_with X x) \
			$(use_with fftw) \
			$(use_with grib) \
			$(use_with hdf) \
			$(use_with hdf5) \
			$(use_with netcdf) \
			$(use_with imagemagick Magick) \
			$(use_with openmp) \
			$(use_with udunits) \
			$(use_with wxwidgets wxWidgets) \
			$@
	}
	configuration --disable-python_module
	if use python; then
		python_execute_function -s configuration --enable-python_module
	fi
}

src_compile() {
	default
	if use python; then
		python_src_compile
	fi
}

src_test() {
	cd "${S}"/testsuite
	echo ".r test_suite" | ../src/gdl
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use python; then
		installation() {
			exeinto $(python_get_sitedir)
			newexe src/.libs/libgdl.so.0.0.0 GDL.so || die
		}
		python_execute_function -s installation
	fi
	dodoc README PYTHON.txt AUTHORS ChangeLog NEWS TODO HACKING
}
