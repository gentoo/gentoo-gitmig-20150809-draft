# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kinfocenter/kinfocenter-4.0.4.ebuild,v 1.1 2008/05/15 23:46:05 ingmar Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The KDE Info Center"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook ieee1394 opengl"

DEPEND="!<kde-base/systemsettings-4.0.3:${SLOT}
	ieee1394? ( sys-libs/libraw1394 )
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}
	sys-apps/pciutils
	sys-apps/usbutils"

KMEXTRACTONLY="apps/cmake/modules/"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with ieee1394 RAW1394)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_compile
}
