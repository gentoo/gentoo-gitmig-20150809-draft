# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/vtk/vtk-5.4.2-r1.ebuild,v 1.14 2010/11/09 07:57:14 xarthisius Exp $

EAPI="3"
PYTHON_DEPEND="python? 2"

inherit cmake-utils eutils flag-o-matic java-pkg-opt-2 python qt4 versionator toolchain-funcs

# Short package version
SPV="$(get_version_component_range 1-2)"

DESCRIPTION="The Visualization Toolkit"
HOMEPAGE="http://www.vtk.org"
SRC_URI="http://www.${PN}.org/files/release/${SPV}/${P}.tar.gz
		examples? ( http://www.${PN}.org/files/release/${SPV}/${PN}data-${PV}.tar.gz )
		doc? ( http://www.${PN}.org/doc/release/${SPV}/${PN}DocHtml-${PV}.tar.gz )"

LICENSE="BSD LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="boost cg doc examples mpi patented python qt4 tcl tk threads"
RDEPEND="mpi? ( || (
					sys-cluster/openmpi
					sys-cluster/mpich2[cxx] ) )
	cg? ( media-gfx/nvidia-cg-toolkit )
	tcl? ( >=dev-lang/tcl-8.2.3 )
	tk? ( >=dev-lang/tk-8.2.3 )
	java? ( >=virtual/jre-1.5 )
	qt4? ( x11-libs/qt-core:4
			x11-libs/qt-opengl:4
			x11-libs/qt-gui:4
			x11-libs/qt-sql )
	examples? ( x11-libs/qt-core:4[qt3support]
			x11-libs/qt-gui:4[qt3support] )
	dev-libs/expat
	dev-libs/libxml2
	media-libs/freetype
	virtual/jpeg
	media-libs/libpng
	media-libs/tiff
	virtual/opengl
	x11-libs/libXmu"

DEPEND="${RDEPEND}
		java? ( >=virtual/jdk-1.5 )
		boost? ( >=dev-libs/boost-1.40.0 )
		>=dev-util/cmake-2.6"

S="${WORKDIR}"/VTK

pkg_setup() {
	echo
	einfo "Please note that the VTK build occasionally fails when"
	einfo "using parallel make. Hence, if you experience a build"
	einfo "failure please try re-emerging with MAKEOPTS=\"-j1\" first."
	echo

	java-pkg-opt-2_pkg_setup

	use python && python_set_active_version 2
	use qt4 && qt4_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-cg-path.patch
	epatch "${FILESDIR}"/${PN}-5.2.0-tcl-install.patch
	epatch "${FILESDIR}"/${P}-boost-property_map.patch
	epatch "${FILESDIR}"/${P}-libpng14.patch
	sed -e "s:@VTK_TCL_LIBRARY_DIR@:/usr/$(get_libdir):" \
		-i Wrapping/Tcl/pkgIndex.tcl.in \
		|| die "Failed to fix tcl pkgIndex file"
}

src_configure() {
	# general configuration
	local mycmakeargs=(
		-Wno-dev
		-DVTK_INSTALL_PACKAGE_DIR=/$(get_libdir)/${PN}-${SPV}
		-DCMAKE_SKIP_RPATH=YES
		-DVTK_DIR="${S}"
		-DVTK_INSTALL_LIB_DIR=/$(get_libdir)/
		-DVTK_DATA_ROOT:PATH=/usr/share/${PN}/data
		-DCMAKE_INSTALL_PREFIX=/usr
		-DBUILD_SHARED_LIBS=ON
		-DVTK_USE_SYSTEM_FREETYPE=ON
		-DVTK_USE_SYSTEM_JPEG=ON
		-DVTK_USE_SYSTEM_PNG=ON
		-DVTK_USE_SYSTEM_TIFF=ON
		-DVTK_USE_SYSTEM_ZLIB=ON
		-DVTK_USE_SYSTEM_EXPAT=ON
		-DVTK_USE_SYSTEM_LIBXML2=ON
		-DBUILD_TESTING=OFF
		-DBUILD_EXAMPLES=OFF
		-DVTK_USE_HYBRID=ON
		-DVTK_USE_GL2PS=ON
		-DVTK_USE_RENDERING=ON)

	# use flag triggered options
	mycmakeargs+=(
		$(cmake-utils_use boost VTK_USE_BOOST)
		$(cmake-utils_use cg VTK_USE_CG_SHADERS)
		$(cmake-utils_use tcl VTK_WRAP_TCL)
		$(cmake-utils_use tk VTK_USE_TK)
		$(cmake-utils_use threads VTK_USE_PARALLEL)
		$(cmake-utils_use patented VTK_USE_PATENTED)
		$(cmake-utils_use doc DOCUMENTATION_HTML_HELP)
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use mpi VTK_USE_MPI))

	# mpi needs the parallel framework
	if use mpi && use !threads; then
		mycmakeargs+=(-DVTK_USE_PARALLEL=ON)
	fi

	if use java; then
		mycmakeargs+=(
			-DVTK_WRAP_JAVA=ON
			-DJAVA_AWT_INCLUDE_PATH=`java-config -O`/include
			-DJAVA_INCLUDE_PATH:PATH=`java-config -O`/include
			-DJAVA_INCLUDE_PATH2:PATH=`java-config -O`/include/linux)

		if [ "${ARCH}" == "amd64" ]; then
			mycmakeargs+=(-DJAVA_AWT_LIBRARY=`java-config -O`/jre/lib/${ARCH}/libjawt.so)
		else
			mycmakeargs+=(-DJAVA_AWT_LIBRARY:PATH=`java-config -O`/jre/lib/i386/libjawt.so)
		fi
	fi

	if use python; then
		mycmakeargs+=(
			-DVTK_WRAP_PYTHON=ON
			-DPYTHON_INCLUDE_PATH=$(python_get_includedir)
			-DPYTHON_LIBRARY=$(python_get_library)
			-DVTK_PYTHON_SETUP_ARGS:STRING=--root="${D}")
	fi

	if use qt4 ; then
		mycmakeargs+=(
			-DVTK_USE_GUISUPPORT=ON
			-DVTK_USE_QVTK=ON
			-DVTK_USE_QVTK_QTOPENGL=ON
			-DQT_WRAP_CPP=ON
			-DQT_WRAP_UI=ON)
	fi

	if use qt4; then
		mycmakeargs+=(
			-DVTK_INSTALL_QT_DIR=/$(get_libdir)/qt4/plugins/${PN}
			-DDESIRED_QT_VERSION=4
			-DQT_MOC_EXECUTABLE=/usr/bin/moc
			-DQT_UIC_EXECUTABLE=/usr/bin/uic
			-DQT_INCLUDE_DIR=/usr/include/qt4
			-DQT_QMAKE_EXECUTABLE=/usr/bin/qmake)
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# install docs
	dohtml "${S}"/README.html || die "Failed to install docs"

	# install Tcl docs
	docinto vtk_tcl
	dodoc "${S}"/Wrapping/Tcl/README || \
		die "Failed to install Tcl docs"

	# install examples
	if use examples; then
		dodir /usr/share/${PN} || \
			die "Failed to create data/examples directory"

		cp -pPR "${S}"/Examples "${D}"/usr/share/${PN}/examples || \
			die "Failed to copy example files"

		# fix example's permissions
		find "${D}"/usr/share/${PN}/examples -type d -exec \
			chmod 0755 {} \; || \
			die "Failed to fix example directories permissions"
		find "${D}"/usr/share/${PN}/examples -type f -exec \
			chmod 0644 {} \; || \
			die "Failed to fix example files permissions"

		cp -pPR "${WORKDIR}"/VTKData "${D}"/usr/share/${PN}/data || \
			die "Failed to copy data files"

		# fix data's permissions
		find "${D}"/usr/share/${PN}/data -type d -exec \
			chmod 0755 {} \; || \
			die "Failed to fix data directories permissions"
		find "${D}"/usr/share/${PN}/data -type f -exec \
			chmod 0644 {} \; || \
			die "Failed to fix data files permissions"
	fi

	#install big docs
	if use doc; then
		cd "${WORKDIR}"/html
		rm -f *.md5 || die "Failed to remove superfluous hashes"
		einfo "Installing API docs. This may take some time."
		insinto "/usr/share/doc/${PF}/api-docs"
		doins -r ./* || die "Failed to install docs"
	fi

	# environment
	echo "VTK_DATA_ROOT=/usr/share/${PN}/data" >> "${T}"/40${PN}
	echo "VTK_DIR=/usr/$(get_libdir)/${PN}-${SPV}" >> "${T}"/40${PN}
	echo "VTKHOME=/usr" >> "${T}"/40${PN}
	doenvd "${T}"/40${PN}
}

pkg_postinst() {
	if use patented; then
		ewarn "Using patented code in VTK may require a license."
		ewarn "For more information, please read:"
		ewarn "http://public.kitware.com/cgi-bin/vtkfaq?req=show&file=faq07.005.htp"
	fi

	if use python; then
		python_mod_optimize vtk
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup vtk
	fi
}
