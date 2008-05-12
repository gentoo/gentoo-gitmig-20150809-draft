# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/paraview/paraview-2.6.2.ebuild,v 1.4 2008/05/12 13:53:51 markusle Exp $

inherit distutils eutils flag-o-matic toolchain-funcs versionator python

MY_PN="${PN/p/P}"
MY_PN="${MY_PN/v/V}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="ParaView is a powerful scientific data visualization application"
HOMEPAGE="http://www.paraview.org"
SRC_URI="http://www.${MY_PN}.org/files/v2.6/${MY_P}.tar.gz"

LICENSE="paraview"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="mpi python hdf5 doc examples threads"
RDEPEND="hdf5? ( sci-libs/hdf5 )
	mpi? ( sys-cluster/mpich )
	python? ( >=dev-lang/python-2.0 )
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	dev-libs/expat
	sys-libs/zlib
	media-libs/freetype
	virtual/opengl
	dev-lang/tcl
	dev-lang/tk
	sci-libs/netcdf
	x11-libs/libXmu"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	>=dev-util/cmake-2.4.3"

PVLIBDIR="$(get_libdir)/${MY_PN}-$(get_version_component_range 1-2)"
BUILDDIR="${WORKDIR}/build"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	mkdir "${BUILDDIR}" || die "Failed to generate build directory"
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.6.0-hdf5-zlib.patch
	epatch "${FILESDIR}"/${PN}-2.6.0-include.patch
	epatch "${FILESDIR}"/${P}-tkImgGIF.patch
}

src_compile() {
	cd "${BUILDDIR}"
	local CMAKE_VARIABLES=""
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_BACKWARDS_COMPATIBILITY=2.2"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPV_INSTALL_LIB_DIR:PATH=/${PVLIBDIR}"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_SKIP_RPATH:BOOL=YES"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_RPATH:BOOL=NO"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_INSTALL_PREFIX:PATH=/usr"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_SHARED_LIBS:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_FREETYPE:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_JPEG:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_PNG:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_TIFF:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_ZLIB:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_EXPAT:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DEXPAT_INCLUDE_DIR:PATH=/usr/include"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DEXPAT_LIBRARY=/usr/$(get_libdir)/libexpat.so"

	if use hdf5; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPARAVIEW_USE_SYSTEM_HDF5:BOOL=ON"
	fi

	if use mpi; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_MPI:BOOL=ON"
	fi

	if use python; then
		python_version
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPARAVIEW_WRAP_PYTHON:BOOL=ON"
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPYTHON_INCLUDE_PATH:PATH=/usr/include/python${PYVER}"
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPYTHON_LIBRARY:PATH=/usr/$(get_libdir)/libpython${PYVER}.so"
	fi

	use doc && CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_DOCUMENTATION:BOOL=ON"

	if use examples; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_EXAMPLES:BOOL=ON"
	else
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_EXAMPLES:BOOL=OFF"
	fi

	if use threads; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_USE_PTHREADS:BOOL=ON"
	else
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_USE_PTHREADS:BOOL=OFF"
	fi

	cmake ${CMAKE_VARIABLES} "${S}" \
		|| die "cmake configuration failed"

	emake || die "emake failed"

}

src_install() {
	cd "${BUILDDIR}"
	emake DESTDIR="${D}" install || die "make install failed"

	# set up the environment
	echo "LDPATH=/usr/${PVLIBDIR}" >> "${T}"/40${PN}
	doenvd "${T}"/40${PN}
}
