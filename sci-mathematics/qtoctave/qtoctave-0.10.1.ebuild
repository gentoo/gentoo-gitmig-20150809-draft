# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/qtoctave/qtoctave-0.10.1.ebuild,v 1.2 2012/07/26 15:03:00 kensington Exp $

EAPI="2"

CMAKE_IN_SOURCE_BUILD=1
inherit eutils cmake-utils

PID=2054

DESCRIPTION="QtOctave is a Qt4 front-end for Octave"
HOMEPAGE="http://forja.rediris.es/projects/csl-qtoctave/"
SRC_URI="http://forja.rediris.es/frs/download.php/${PID}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.6:4
	>=x11-libs/qt-svg-4.6:4"

RDEPEND="${DEPEND}
	>=sci-mathematics/octave-3.2.0"

DOCS="readme.txt leeme.txt"

src_prepare() {
	sed -i -e 's/Categories=/Categories=Development;/' \
		qtoctave/src/config_files/qtoctave.desktop || die 'sed failed.'
}

src_configure() {
	mycmakeargs=(-DCMAKE_SKIP_RPATH:BOOL=YES )
	cmake-utils_src_configure
}
