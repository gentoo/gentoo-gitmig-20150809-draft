# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/opencpn/opencpn-2.3.1.ebuild,v 1.3 2011/06/15 08:57:04 scarabeus Exp $

EAPI=4

WX_GTK_VER="2.8"
inherit cmake-utils wxwidgets

MY_P=OpenCPN-${PV}-Source
DESCRIPTION="a free, open source software for marine navigation"
HOMEPAGE="http://opencpn.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# build system seems very fragile:
# we need to force most useflags to make it actually build
IUSE="gpsd"

# s57 must be enabled in this release to make the buils succeed
# if s57 may be disabled in a later release virtual/glu may be
# use conditional
RDEPEND="gpsd? ( >=sci-geosciences/gpsd-2.90 )
	sys-libs/zlib
	virtual/opengl
	>=x11-libs/wxGTK-2.8.8[X]"
DEPEND="${DEPEND}
	sys-devel/gettext"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use gpsd GPSD)
		-DUSE_S57=ON
		-DUSE_GARMINHOST=ON
		-DUSE_WIFI_CLIENT=OFF
	)

	cmake-utils_src_configure
}
