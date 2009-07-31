# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/qtoctave/qtoctave-0.8.1.ebuild,v 1.4 2009/07/31 13:12:55 markusle Exp $

EAPI="1"

CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils

DESCRIPTION="QtOctave is a Qt4 front-end for Octave"
HOMEPAGE="http://forja.rediris.es/projects/csl-qtoctave/"
SRC_URI="http://forja.rediris.es/frs/download.php/877/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
		x11-libs/qt-svg:4"

RDEPEND="${DEPEND}
		>=sci-mathematics/octave-3.0.0"

S="${WORKDIR}"/${P}/${PN}


src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.4.patch
}

src_compile() {
	mycmakeargs="-DCMAKE_SKIP_RPATH:BOOL=YES"
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc readme.txt news.txt
}
