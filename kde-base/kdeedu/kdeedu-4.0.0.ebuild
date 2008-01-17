# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-4.0.0.ebuild,v 1.1 2008/01/17 23:46:55 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE education module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook cviewer opengl readline solver kig-scripting fits
nova sbig usb designer-plugin gps"  

LICENSE="GPL-2 LGPL-2"

RESTRICT="test"

COMMONDEPEND="gps? ( sci-geosciences/gpsd )
		fits? ( sci-libs/cfitsio )
		nova? ( >=sci-libs/libnova-0.12.1 )
		sbig? ( sci-libs/indilib
			usb? ( dev-libs/libusb ) )
		cviewer? ( >=dev-cpp/eigen-1.0.5
			>=sci-chemistry/openbabel-2.1
			virtual/opengl )
		solver? ( dev-ml/facile )
		opengl? ( virtual/opengl )
		readline? ( sys-libs/readline )
		kig-scripting? ( >=dev-libs/boost-1.32 )"
		
RDEPEND="${RDEPEND} ${COMMONDEPEND}
	|| ( >=kde-base/kdebase-${PV}:${SLOT} 
		( >=kde-base/knotify-${PV}:${SLOT} >=kde-base/phonon-${PV}:${SLOT} ) )"

PATCHES="${FILESDIR}/kstars-4.0.0-destdir.patch
		${FILESDIR}/marble-4.0.0-fix-tests.patch"

pkg_setup() {
	use cviewer && QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK} opengl"

	kde4-base_pkg_setup
}

src_compile() {
	mycmakeargs="$(cmake-utils_use_with readline Readline)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with cviewer Eigen)
		$(cmake-utils_use_with cviewer OpenBabel2)
		$(cmake-utils_use_with cviewer OpenGL)
		$(cmake-utils_use_with solver OCaml)
		$(cmake-utils_use_with solver Libfacile)
		$(cmake-utils_use_with kig-scripting BoostPython)
		$(cmake-utils_use_with fits CFitsio)
		$(cmake-utils_use_with nova Nova)
		$(cmake-utils_use_with sbig SBIG)
		$(cmake-utils_use_with usb USB)
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)"

	if use gps; then
		mycmakeargs="${mycmakeargs} -DHAVE_LIBGPS=1"
	else
		sed -i -e 's:FIND_LIBRARY(libgps_LIBRARIES gps):# LIBGPS DISABLED &:' \
			marble/Findlibgps.cmake || die "sed failed."
	fi

	kde4-base_src_compile
}
