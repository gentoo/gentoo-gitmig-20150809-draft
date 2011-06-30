# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkartegt/qlandkartegt-1.2.1.ebuild,v 1.1 2011/06/30 12:20:03 scarabeus Exp $

EAPI=4

inherit base cmake-utils

DESCRIPTION="View and upload map files, track and waypoint data to your Garmin GPS."
HOMEPAGE="http://www.qlandkarte.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="exif gps"

RDEPEND="
	>=sci-libs/gdal-1.6
	>=sci-libs/proj-4.7
	sci-geosciences/gpsbabel
	media-libs/libexif
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-sql:4
	x11-libs/qt-webkit:4
	exif? ( media-gfx/exiv2 )
	gps? ( >=sci-geosciences/gpsd-2.90 )
"

PATCHES=(
	"${FILESDIR}/1.1.2-fix_automagicness.patch"
)

src_configure() {
	local mycmakeargs=(
		"-DWITH_DMTX=OFF" # not in main tree
		$(cmake-utils_use_with exif EXIF)
		$(cmake-utils_use_with gps GPSD)
	)
	cmake-utils_src_configure
}
