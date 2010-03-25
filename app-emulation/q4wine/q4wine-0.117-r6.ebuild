# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/q4wine/q4wine-0.117-r6.ebuild,v 1.1 2010/03/25 20:29:55 hwoarang Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="Qt4 GUI for wine"
HOMEPAGE="http://q4wine.brezblock.org.ua/"
SRC_URI="mirror://sourceforge/${PN}/${PF}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug icoutils winetriks embedded-fuseiso development"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4[sqlite]
	dev-util/cmake
	embedded-fuseiso? ( dev-libs/libzip >=sys-libs/glibc-2.0 >=sys-fs/fuse-2.7.0 )"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4[sqlite]
	app-admin/sudo
	app-emulation/wine
	>=sys-apps/which-2.19
	icoutils? ( >=media-gfx/icoutils-0.26.0 )
	x11-misc/xdg-utils"

DOCS="README"

S="${WORKDIR}/${PF}"

src_configure() {
	mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use debug DEBUG) \
		$(cmake-utils_use_with icoutils ICOUTILS) \
		$(cmake-utils_use_with winetriks WINETRIKS) \
		$(cmake-utils_use_with embedded-fuseiso EMBEDDED_FUSEISO) \
		$(cmake-utils_use_with development DEVELOP_STUFF)"

	cmake-utils_src_configure
}
