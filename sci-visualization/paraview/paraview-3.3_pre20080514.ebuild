# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/paraview/paraview-3.3_pre20080514.ebuild,v 1.1 2008/05/16 01:45:09 markusle Exp $

EAPI="1"

inherit distutils eutils flag-o-matic toolchain-funcs versionator python qt4

MY_PV=3.3

DESCRIPTION="ParaView is a powerful scientific data visualization application"
HOMEPAGE="http://www.paraview.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="paraview"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="mpi python hdf5 doc examples threads qt4"
RDEPEND="hdf5? ( sci-libs/hdf5 )
	mpi? ( || (
				sys-cluster/openmpi
				sys-cluster/mpich2 ) )
	python? ( >=dev-lang/python-2.0 )
	dev-libs/libxml2
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	dev-libs/expat
	sys-libs/zlib
	media-libs/freetype
	virtual/opengl
	sci-libs/netcdf
	x11-libs/libXmu"

DEPEND="${RDEPEND}
		doc? ( app-doc/doxygen )
		>=dev-util/cmake-2.4.5"

PVLIBDIR="$(get_libdir)/${PN}-${MY_PV}"
BUILDDIR="${WORKDIR}/build"
S="${WORKDIR}"/ParaView3

#QT4_BUILT_WITH_USE_CHECK="qt3support"

pkg_setup() {
	use qt4 && qt4_pkg_setup
	if use mpi && has_version sys-cluster/mpich2; then
		if ! built_with_use sys-cluster/mpich2 cxx; then
			die "Please re-emerge sys-cluster/mpich2 with USE=\"cxx\""
		fi
	fi
}

src_unpack() {
	unpack ${A}
	mkdir "${BUILDDIR}" || die "Failed to generate build directory"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
	epatch "${FILESDIR}"/${P}-qt.patch
	epatch "${FILESDIR}"/${PN}-3.2.1-openmpi.patch

	# rename paraview's assistant wrapper
	if use qt4; then
		sed -e "s:\"assistant\":\"paraview-assistant\":" \
			-i Applications/Client/MainWindow.cxx \
			|| die "Failed to fix assistant wrapper call"
	fi

	# fix GL issues
	sed -e "s:DEPTH_STENCIL_EXT:DEPTH_COMPONENT24:" \
		-i VTK/Rendering/vtkOpenGLRenderWindow.cxx \
		|| die "Failed to fix GL issues."
}

src_compile() {
	cd "${BUILDDIR}"
	local CMAKE_VARIABLES=""
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPV_INSTALL_LIB_DIR:PATH=/${PVLIBDIR}"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_SKIP_RPATH:BOOL=YES"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_RPATH:BOOL=OFF"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_INSTALL_PREFIX:PATH=/usr"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_SHARED_LIBS:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_FREETYPE:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_JPEG:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_PNG:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_TIFF:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_ZLIB:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_EXPAT:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DEXPAT_INCLUDE_DIR:PATH=/usr/include"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DEXPAT_LIBRARY=/usr/$(get_libdir)/libexpat.so"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DOPENGL_gl_LIBRARY=/usr/$(get_libdir)/libGL.so"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DOPENGL_glu_LIBRARY=/usr/$(get_libdir)/libGLU.so"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_GLEXT_FILE=/usr/include/GL/glext.h"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_GLXEXT_FILE=/usr/include/GL/glxext.h"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_COLOR_MAKEFILE:BOOL=TRUE"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_LIBXML2:BOOL=ON"
	# paraview uses a non exisiting call to boost's graph library
	# maybe upstream needs to update
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_BOOST:BOOL=OFF"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_OFFSCREEN=TRUE"

	# paraview used the deprecated img_convert(..) call; hence disable
	# until upstream has switched to swscale
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_FFMPEG_ENCODER:BOOL=OFF"
	if use hdf5; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPARAVIEW_USE_SYSTEM_HDF5:BOOL=ON"
	fi

	if use mpi; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPARAVIEW_USE_MPI:BOOL=ON"
	fi

	if use python; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPARAVIEW_ENABLE_PYTHON:BOOL=ON"
	fi

	use doc && CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_DOCUMENTATION:BOOL=ON"

	if use examples; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_EXAMPLES:BOOL=ON"
	else
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_EXAMPLES:BOOL=OFF"
	fi

	if use qt4; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPARAVIEW_BUILD_QT_GUI:BOOL=ON"
	else
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DPARAVIEW_BUILD_QT_GUI:BOOL=OFF"
	fi

	if use threads; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_USE_PTHREADS:BOOL=ON"
	else
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DCMAKE_USE_PTHREADS:BOOL=OFF"
	fi

	#CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_OFFSCREEN=TRUE"

	cmake ${CMAKE_VARIABLES} "${S}" \
		|| die "cmake configuration failed"

	emake -j1 || die "emake failed"

}

src_install() {
	cd "${BUILDDIR}"
	make DESTDIR="${D}" install || die "make install failed"

	# rename the assistant wrapper
	if use qt4; then
		mv "${D}"/usr/bin/assistant "${D}"/usr/bin/paraview-assistant \
			|| die "Failed to rename assistant wrapper"
		chmod 0755 "${D}"/usr/$(get_libdir)/${PN}-${MY_PV}/assistant-real \
			|| die "Failed to change permissions on assistant wrapper"
	fi

	# set up the environment
	echo "LDPATH=/usr/${PVLIBDIR}" >> "${T}"/40${PN}
	doenvd "${T}"/40${PN}
}
