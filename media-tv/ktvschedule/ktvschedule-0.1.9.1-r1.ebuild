# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ktvschedule/ktvschedule-0.1.9.1-r1.ebuild,v 1.1 2009/02/14 20:10:07 carlo Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KDE frontend for TV listings guide grabbers xmltv and nxtvpeg"
HOMEPAGE="http://ktvschedule.berlios.de/"
# SRC_URI hardcoded because of an upstream tarring bug
SRC_URI="mirror://berlios/ktvschedule/ktvschedule-0.1.9.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
DEPEND="
	|| ( media-tv/nxtvepg media-tv/xmltv )
	|| ( ( kde-base/korganizer:3.5 kde-base/kalarm:3.5 ) kde-base/kdepim:3.5 )"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/ktvschedule-0.1.9.1-gcc43.diff"
	"${FILESDIR}/ktvschedule-0.1.9.1-desktop-file.diff"
	)

src_unpack(){
	kde_src_unpack
	rm -f "${S}"/configure
}
