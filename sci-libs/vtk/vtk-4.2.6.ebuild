# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/vtk/vtk-4.2.6.ebuild,v 1.5 2005/08/24 16:20:18 phosphan Exp $

# TODO: need to fix Examples/CMakeLists.txt to build other examples

inherit distutils eutils flag-o-matic toolchain-funcs versionator

MY_PV="$(get_version_component_range 1-2)"

DESCRIPTION="The Visualization Toolkit"
HOMEPAGE="http://www.vtk.org"
SRC_URI="mirror://sourceforge/${PN}/VTK-${MY_PV}-LatestRelease.tar.gz
	doc? ( mirror://sourceforge/${PN}/VTKDocHtml-${MY_PV}.tar.gz )
	examples? ( mirror://sourceforge/${PN}/VTKData-${MY_PV}.tar.gz )"

LICENSE="BSD"
KEYWORDS="~x86"
SLOT="0"
IUSE="doc examples java mpi patented python tcltk threads"
RDEPEND="java? ( virtual/jdk )
	mpi? ( sys-cluster/mpich )
	python? ( >=dev-lang/python-2.0 )
	>=dev-lang/tcl-8.2.3
	>=dev-lang/tk-8.2.3
	dev-libs/expat
	media-libs/jpeg
	media-libs/libpng
	media-libs/tiff
	virtual/opengl
	virtual/x11"
DEPEND="${RDEPEND}
	>=dev-util/cmake-1.8"

S=${WORKDIR}/VTK

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	# gcc versions 3.2.x seem to have sse-related bugs that are triggered
	# by VTK when compiling for pentium3/4
	if [ "$(gcc-major-version)" -eq 3 -a "$(gcc-minor-version)" -eq 2 -a \
		"$(get-flag -march)" == "-march=pentium4" ]; then
		filter-mfpmath sse
		filter-flags "-msse -msse2"
		echo "$(get-flag -march)"
	fi

	# build list of config variable define's to pass to cmake
	CMAKE_VARIABLES="-DCMAKE_INSTALL_PREFIX:PATH=/usr"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_SHARED_LIBS:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_JPEG:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_PNG:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_TIFF:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_ZLIB:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_SYSTEM_EXPAT:BOOL=ON"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DBUILD_TESTING:BOOL=OFF"
	CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_HYBRID:BOOL=ON"
	use examples && CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_DATA_ROOT:PATH=/usr/share/${PN}/data -DBUILD_EXAMPLES:BOOL=ON"
	if use java; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_WRAP_JAVA:BOOL=ON"
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DJAVA_AWT_LIBRARY:PATH=`java-config -O`/jre/lib/i386/libjawt.so"
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DJAVA_AWT_INCLUDE_PATH:PATH=`java-config -O`/include"
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DJAVA_INCLUDE_PATH:PATH=`java-config -O`/include"
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DJAVA_INCLUDE_PATH2:PATH=`java-config -O`/include/linux"
	fi
	if use mpi; then
		CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_MPI:BOOL=ON"
		use !threads && CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_PARALLEL:BOOL=ON"
	fi
	use python && CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_WRAP_PYTHON:BOOL=ON"
	use tcltk && CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_WRAP_TCL:BOOL=ON"
	use threads && CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_PARALLEL:BOOL=ON"
	use patented && CMAKE_VARIABLES="${CMAKE_VARIABLES} -DVTK_USE_PATENTED:BOOL=ON"

	cmake ${CMAKE_VARIABLES} . || die "cmake configuration failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# fix config file
	sed -i -e "s:${D}:/:g" ${D}/usr/lib/${PN}/VTKConfig.cmake

	LDPATH="/usr/lib/${PN}"
	# install python modules
	if use python; then
		distutils_python_version
		LDPATH="${LDPATH}:/usr/lib/python${PYVER}/site-packages/${PN}_python"
		cd ${S}/Wrapping/Python
		docinto vtk_python
		distutils_src_install

		# make symlinks to vtk python modules
		FILES="${D}/usr/lib/vtk/libvtk*Python*.so"
		for file in ${FILES}
		do
			dosym ${file} /usr/lib/python${PYVER}/site-packages/${PN}_python
		done
	fi

	# install jar
	use java && dojar ${S}/bin/vtk.jar

	# install documentation
	use doc && dohtml -r ${WORKDIR}/html/

	# install examples
	if use examples; then
		dodir /usr/share/${PN}
		cp -pPR ${S}/Examples ${D}/usr/share/${PN}/examples

		# fix example's permissions
		find ${D}/usr/share/${PN}/examples -type d -exec chmod 0755 {} \;
		find ${D}/usr/share/${PN}/examples -type f -exec chmod 0644 {} \;

		# VTKData uses a hyphen instead of a dot
		MY_PV_HYPHEN=`echo ${MY_PV} | sed -e "s/\./-/"`
		dodir /usr/share/${PN}
		cp -pPR ${WORKDIR}/VTKData-release-${MY_PV_HYPHEN} ${D}/usr/share/${PN}/data

		# fix data's permissions
		find ${D}/usr/share/${PN}/data -type d -exec chmod 0755 {} \;
		find ${D}/usr/share/${PN}/data -type f -exec chmod 0644 {} \;
	fi

	# environment
	echo "LDPATH=${LDPATH}" > ${T}/40${PN}
	echo "VTK_DATA_ROOT=/usr/share/${PN}/data" >> ${T}/40${PN}
	if use java; then
		echo "CLASSPATH=/usr/share/${PN}/${PN}.jar" >> ${T}/40${PN}
		echo "LD_LIBRARY_PATH=/usr/lib/${PN}" >> ${T}/40${PN}
	fi
	use tcltk && echo "TCLLIBPATH=/usr/lib/${PN}/tcl" >> ${T}/40${PN}
	doenvd ${T}/40${PN}
}

pkg_postinst() {
	if use patented; then
		ewarn "Using patented code in VTK may require a license."
		ewarn "For more information, please read:"
		ewarn "http://public.kitware.com/cgi-bin/vtkfaq?req=show&file=faq07.005.htp"
	fi
}
