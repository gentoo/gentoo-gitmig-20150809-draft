# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nomacs/nomacs-0.3.2.ebuild,v 1.1 2012/06/29 07:37:18 yngwin Exp $

EAPI=4
#LANGS="als de en ru zh" TODO: translation handling

inherit cmake-utils

DESCRIPTION="Qt4-based image viewer"
HOMEPAGE="http://www.nomacs.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="raw"

RDEPEND=">=media-gfx/exiv2-0.20[xmp,zlib]
	>=x11-libs/qt-core-4.7.0:4
	>=x11-libs/qt-gui-4.7.0:4
	raw? ( media-libs/libraw
		media-libs/opencv[qt4] )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable raw RAW)
	)
	cmake-utils_src_configure
}
