# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/openscenegraph/openscenegraph-2.8.0.ebuild,v 1.1 2009/02/24 13:26:59 tupone Exp $

EAPI=2
inherit cmake-utils versionator

MY_PN="OpenSceneGraph"
MY_P=${MY_PN}-${PV}
MY_P_MAJOR=${MY_PN}-$(get_version_component_range 1-2)

DESCRIPTION="Open source high performance 3D graphics toolkit"
HOMEPAGE="http://www.openscenegraph.org/projects/osg/"
SRC_URI="http://www.openscenegraph.org/downloads/stable_releases/${MY_P_MAJOR}/source/${MY_P}.zip"

LICENSE="wxWinLL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	net-misc/curl
	net-libs/xulrunner
	gnome-base/librsvg
	media-libs/jpeg
	app-text/poppler-bindings"

DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${MY_P}

mycmakeargs="-DBUILD_OSG_APPLICATIONS=OFF"
DOCS="AUTHORS.txt ChangeLog NEWS.txt"
