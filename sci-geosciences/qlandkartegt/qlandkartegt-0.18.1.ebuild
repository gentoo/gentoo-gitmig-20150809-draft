# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkartegt/qlandkartegt-0.18.1.ebuild,v 1.1 2010/04/27 10:23:44 scarabeus Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="View and upload map files, track and waypoint data to your Garmin GPS."
HOMEPAGE="http://www.qlandkarte.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

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
