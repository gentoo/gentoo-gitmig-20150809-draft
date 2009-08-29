# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/canorus/canorus-0.7_p1002.ebuild,v 1.2 2009/08/29 12:30:43 ssuominen Exp $

EAPI=2
CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils

MY_PV=${PV/_p/.R}

DESCRIPTION="a free extensible music score editor"
HOMEPAGE="http://canorus.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${PN}_${MY_PV}_source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	sys-libs/zlib
	media-libs/alsa-lib
	>=x11-libs/qt-svg-4.4:4
	>=x11-libs/qt-core-4.4:4
	>=x11-libs/qt-assistant-4.4:4"
DEPEND="${RDEPEND}
	dev-lang/swig"

S=${WORKDIR}/${PN}-${MY_PV}

pkg_setup() {
	mycmakeargs="${mycmakeargs} -DNO_RUBY=1" # Didn't manage to get it working
	PATCHES=( "${FILESDIR}/${PV}-sandbox.patch"
		"${FILESDIR}/${PV}-desktop_entry.patch" )
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS DEVELOPERS NEWS README TODO
	doman debian/canorus.6
	newicon src/ui/images/clogosm.png canorus.png
	domenu canorus.desktop
}
