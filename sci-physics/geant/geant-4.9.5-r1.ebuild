# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/geant/geant-4.9.5-r1.ebuild,v 1.1 2012/03/13 21:52:56 bicatali Exp $

EAPI=4

inherit cmake-utils eutils fortran-2 versionator

PV1=$(get_version_component_range 1 ${PV})
PV2=$(get_version_component_range 2 ${PV})
PV3=$(get_version_component_range 3 ${PV})
MYP=${PN}$(replace_version_separator 3 .)

DESCRIPTION="Toolkit for simulation of passage of particles through matter"
HOMEPAGE="http://geant4.cern.ch/"
SRC_URI="http://geant4.cern.ch/support/source/${MYP}.tar.gz"

LICENSE="geant4"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="+data dawn examples gdml geant3 granular motif opengl openinventor
	raytracerx qt4 static-libs test vrml zlib"

RDEPEND="virtual/fortran
	>=sci-physics/clhep-2.1.1
	dawn? ( media-gfx/dawn )
	gdml? ( dev-libs/xerces-c )
	motif? ( x11-libs/openmotif:0 )
	openinventor? ( media-libs/openinventor )
	raytracerx? ( x11-libs/libX11 x11-libs/libXmu )
	qt4? ( x11-libs/qt-gui:4 opengl? ( x11-libs/qt-opengl:4 ) )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

PATCHES=( "${FILESDIR}"/${PN}-4.9.4-zlib.patch )

src_configure() {
	mycmakeargs=(
		-DGEANT4_USE_SYSTEM_CLHEP=ON
		$(cmake-utils_use data GEANT4_INSTALL_DATA)
		$(cmake-utils_use dawn GEANT4_USE_NETWORKDAWN)
		$(cmake-utils_use gdml GEANT4_USE_GDML)
		$(cmake-utils_use geant3 GEANT4_USE_G3TOG4)
		$(cmake-utils_use granular GEANT4_BUILD_GRANULAR_BUILD)
		$(cmake-utils_use motif GEANT4_USE_XM)
		$(cmake-utils_use opengl GEANT4_USE_OPENGL_X11)
		$(cmake-utils_use openinventor GEANT4_USE_INVENTOR)
		$(cmake-utils_use qt4 GEANT4_USE_QT)
		$(cmake-utils_use raytracerx GEANT4_USE_RAYTRACER_X11)
		$(cmake-utils_use test GEANT4_ENABLE_TESTING)
		$(cmake-utils_use vrml GEANT4_USE_NETWORKVRML)
		$(cmake-utils_use zlib GEANT4_USE_SYSTEM_ZLIB)
		$(cmake-utils_use_build static-libs STATIC_LIBS)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	insinto /usr/share/doc/${PF}
	local mypv="${PV1}.${PV2}.${PV3}"
	doins ReleaseNotes/ReleaseNotes${mypv}.html
	[[ -e ReleaseNotes/Patch${mypv}-1.txt ]] && \
		dodoc ReleaseNotes/Patch${mypv}-*.txt
	use examples && doins -r examples
}

pkg_postinst() {
	elog "The following scripts are provided for backward compatibility:"
	elog "$(ls -1 ${EROOT}usr/share/Geant4-${PV2}.${PV3}.*/geant4make/*sh)"
}
