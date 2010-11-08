# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/scantailor/scantailor-0.9.9.ebuild,v 1.3 2010/11/08 23:01:00 maekke Exp $

EAPI=2
inherit cmake-utils eutils

DESCRIPTION="A interactive post-processing tool for scanned pages"
HOMEPAGE="http://scantailor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 GPL-3 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dewarping opengl"

RDEPEND=">=media-libs/libpng-1.2.43
	>=media-libs/tiff-3.9.4
	sys-libs/zlib
	virtual/jpeg
	x11-libs/libXrender
	x11-libs/qt-gui:4
	opengl? ( x11-libs/qt-opengl:4 )"
DEPEND="${RDEPEND}
	dev-libs/boost"

PATCHES=( "${FILESDIR}/${P}-environment_flags.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable dewarping)
		$(cmake-utils_use_enable opengl)
		)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newicon resources/appicon.svg ${PN}.svg
	make_desktop_entry ${PN} "Scan Tailor"
}
