# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/qtoctave/qtoctave-0.9.1-r1.ebuild,v 1.2 2010/11/12 16:39:37 hwoarang Exp $

EAPI="2"

CMAKE_IN_SOURCE_BUILD=1
inherit eutils cmake-utils

PID=1760

DESCRIPTION="QtOctave is a Qt4 front-end for Octave"
HOMEPAGE="http://forja.rediris.es/projects/csl-qtoctave/"
SRC_URI="http://forja.rediris.es/frs/download.php/${PID}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.5
	>=x11-libs/qt-svg-4.5"

RDEPEND="${DEPEND}
	>=sci-mathematics/octave-3.2.0"

S="${WORKDIR}/${P}"
DOCS="readme.txt leeme.txt"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.1-qtinfo.patch
	epatch "${FILESDIR}"/${PN}-0.9.1-qt-version.patch
	epatch "${FILESDIR}"/${PN}-0.9.1-doc-path.patch
	epatch "${FILESDIR}"/${PN}-0.8.1-gcc4.4.patch
}

src_configure() {
	mycmakeargs=(-DCMAKE_SKIP_RPATH:BOOL=YES )
	cmake-utils_src_configure
}
