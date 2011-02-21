# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkartegt/qlandkartegt-1.1.0.ebuild,v 1.1 2011/02/21 10:40:55 hanno Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="View and upload map files, track and waypoint data to your Garmin GPS."
HOMEPAGE="http://www.qlandkarte.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Note: this has unfixed automagics on libexif, libdmtx and gpsd
DEPEND="
	sci-libs/gdal
	sci-libs/proj
	media-libs/libexif
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-sql:4
"
RDEPEND="${DEPEND}
	sci-geosciences/gpsbabel"
