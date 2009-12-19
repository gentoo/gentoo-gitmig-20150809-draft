# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/vtk/vtk-5.4.2-r1.ebuild,v 1.1 2009/12/19 16:41:31 markusle Exp $

EAPI="2"
inherit eutils flag-o-matic toolchain-funcs versionator java-pkg-opt-2 python qt3 qt4 cmake-utils

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
IUSE="boost cg doc examples mpi patented python tcl tk threads qt3 qt4"
RDEPEND="mpi? ( || (
					sys-cluster/openmpi
					sys-cluster/lam-mpi
					sys-cluster/mpich2[cxx] ) )
	python? ( >=dev-lang/python-2.0 )
	cg? ( media-gfx/nvidia-cg-toolkit )
	tcl? ( >=dev-lang/tcl-8.2.3 )
	tk? ( >=dev-lang/tk-8.2.3 )
	java? ( >=virtual/jre-1.5 )
	!qt4? ( qt3? ( >=x11-libs/qt-3.3.4:3 ) )
	qt4? ( x11-libs/qt-core:4
			x11-libs/qt-opengl:4
			x11-libs/qt-gui:4 )
	examples? ( x11-libs/qt-core:4[qt3support]
			x11-libs/qt-gui:4[qt3support] )
	dev-libs/expat
	dev-libs/libxml2
	media-libs/freetype
	media-libs/jpeg
	media-libs/libpng
	media-libs/tiff
	virtual/opengl
	x11-libs/libXmu"

DEPEND="${RDEPEND}
		java? ( >=virtual/jdk-1.5 )
		boost? ( dev-libs/boost )
		>=dev-util/cmake-2.6"

S="${WORKDIR}"/VTK

pkg_setup() {
	echo
	einfo "Please note that the VTK build occasionally fails when"
	einfo "using parallel make. Hence, if you experience a build"
	einfo "failure please try re-emerging with MAKEOPTS=\"-j1\" first."
	echo
	epause 5

	java-pkg-opt-2_pkg_setup
	if use qt3 && use qt4; then
		echo
		ewarn "qt3 and qt4 support for vtk are mutually exclusive and"
		ewarn "qt4 support has therefore been enabled by default."
		echo
	fi

	if use qt4; then
		qt4_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-cg-path.patch
	epatch "${FILESDIR}"/${PN}-5.2.0-tcl-install.patch
	sed -e "s:@VTK_TCL_LIBRARY_DIR@:/usr/$(get_libdir):" \
		-i Wrapping/Tcl/pkgIndex.tcl.in \
		|| die "Failed to fix tcl pkgIndex file"
}

src_configure() {
	# general configuration
	local mycmakeargs="
		-Wno-dev
		-DVTK_INSTALL_PACKAGE_DIR=/$(get_libdir)/${PN}-${SPV}
		-DCMAKE_SKIP_RPATH=YES
		-DVTK_DIR=${S}
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
		-DVTK_USE_RENDERING=ON"

	# use flag triggered options
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use boost VTK_USE_BOOST)
		$(cmake-utils_use cg VTK_USE_CG_SHADERS)
		$(cmake-utils_use tcl VTK_WRAP_TCL)
		$(cmake-utils_use tk VTK_USE_TK)
		$(cmake-utils_use threads VTK_USE_PARALLEL)
		$(cmake-utils_use patented VTK_USE_PATENTED)
		$(cmake-utils_use doc DOCUMENTATION_HTML_HELP)
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use mpi VTK_USE_MPI)"

	# mpi needs the parallel framework
	if use mpi && use !threads; then
		mycmakeargs="${mycmakeargs}
			-DVTK_USE_PARALLEL=ON"
	fi

	if use java; then
		mycmakeargs="${mycmakeargs}
			-DVTK_WRAP_JAVA=ON
			-DJAVA_AWT_INCLUDE_PATH=`java-config -O`/include
			-DJAVA_INCLUDE_PATH:PATH=`java-config -O`/include
			-DJAVA_INCLUDE_PATH2:PATH=`java-config -O`/include/linux"

		if [ "${ARCH}" == "amd64" ]; then
			mycmakeargs="${mycmakeargs}
				-DJAVA_AWT_LIBRARY=`java-config -O`/jre/lib/${ARCH}/libjawt.so"
		else
			mycmakeargs="${mycmakeargs}
				-DJAVA_AWT_LIBRARY:PATH=`java-config -O`/jre/lib/i386/libjawt.so"
		fi
	fi

	if use python; then
		python_version
		mycmakeargs="${mycmakeargs}
			-DVTK_WRAP_PYTHON=ON
			-DPYTHON_INCLUDE_PATH=/usr/include/python${PYVER}
			-DPYTHON_LIBRARY=/usr/$(get_libdir)/libpython${PYVER}.so
			-DVTK_PYTHON_SETUP_ARGS:STRING=--root=${D}"
	fi

	if use qt3 || use qt4 ; then
		mycmakeargs="${mycmakeargs}
			-DVTK_USE_GUISUPPORT=ON
			-DVTK_USE_QVTK=ON
			-DVTK_USE_QVTK_QTOPENGL=ON
			-DQT_WRAP_CPP=ON
			-DQT_WRAP_UI=ON"
	fi

	# these options we only enable if the use request qt3
	# only. In case of qt3 && qt4 or qt4 only qt4 always
	# overrides qt3
	if use qt3 && use !qt4; then
		mycmakeargs="${mycmakeargs}
			-DVTK_INSTALL_QT_DIR=/qt/3/plugins/${PN}
			-DDESIRED_QT_VERSION=3
			-DQT_MOC_EXECUTABLE=/usr/qt/3/bin/moc
			-DQT_UIC_EXECUTABLE=/usr/qt/3/bin/uic
			-DQT_INCLUDE_DIR=/usr/qt/3/include
			-DQT_QT_LIBRARY=/usr/qt/3/$(get_libdir)/libqt.so
			-DQT_QMAKE_EXECUTABLE=/usr/qt/3/bin/qmake"
	fi

	if use qt4; then
		mycmakeargs="${mycmakeargs}
			-DVTK_INSTALL_QT_DIR=/$(get_libdir)/qt4/plugins/${PN}
			-DDESIRED_QT_VERSION=4
			-DQT_MOC_EXECUTABLE=/usr/bin/moc
			-DQT_UIC_EXECUTABLE=/usr/bin/uic
			-DQT_INCLUDE_DIR=/usr/include/qt4
			-DQT_QMAKE_EXECUTABLE=/usr/bin/qmake"
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
}
