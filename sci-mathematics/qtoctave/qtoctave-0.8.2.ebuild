# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/qtoctave/qtoctave-0.8.2.ebuild,v 1.6 2010/07/14 10:27:16 hwoarang Exp $

EAPI="2"

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils multilib

DESCRIPTION="QtOctave is a Qt4 front-end for Octave"
HOMEPAGE="http://forja.rediris.es/projects/csl-qtoctave/"
SRC_URI="http://forja.rediris.es/frs/download.php/1383/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
		x11-libs/qt-svg:4"

RDEPEND="${DEPEND}
		>=sci-mathematics/octave-3.2.0"

S="${WORKDIR}"/${P}/${PN}

PATCHES=(
	"${FILESDIR}"/${PN}-0.8.1-gcc4.4.patch
	"${FILESDIR}"/${P}-rpath.patch
	)

DOCS=(readme.txt news.txt)
