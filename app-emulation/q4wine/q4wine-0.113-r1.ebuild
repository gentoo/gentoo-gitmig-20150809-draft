# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/q4wine/q4wine-0.113-r1.ebuild,v 1.1 2009/10/06 22:36:23 hwoarang Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="Qt4 GUI for wine"
HOMEPAGE="http://q4wine.brezblock.org.ua/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug icoutils winetriks embedded-fuseiso development"

DEPEND="x11-libs/qt-gui:4[debug?]
	x11-libs/qt-sql:4[sqlite,debug?]
	dev-util/cmake
	embedded-fuseiso? ( dev-libs/libzip >=sys-libs/glibc-2.0 >=sys-fs/fuse-2.7.0 )"

RDEPEND="x11-libs/qt-gui:4[debug?]
	x11-libs/qt-sql:4[sqlite,debug?]
	app-admin/sudo
	app-emulation/wine
	>=sys-apps/which-2.19
	icoutils? ( >=media-gfx/icoutils-0.26.0 )"

DOCS="README"

S="${WORKDIR}/${PF}"

src_configure() {
	mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use_with icoutils ICOUTILS) \
		$(cmake-utils_use_with winetriks WINETRIKS) \
		$(cmake-utils_use_with embedded-fuseiso EMBEDDED_FUSEISO) \
		$(cmake-utils_use_with development DEVELOP_STUFF)"

	cmake-utils_src_configure
}
