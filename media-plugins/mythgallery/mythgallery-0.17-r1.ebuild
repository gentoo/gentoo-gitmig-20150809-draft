# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgallery/mythgallery-0.17-r1.ebuild,v 1.1 2005/03/26 08:33:45 cardoe Exp $

inherit myth

DESCRIPTION="Gallery and slideshow module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="opengl exif"

DEPEND=">=sys-apps/sed-4
	opengl? ( virtual/opengl )
	exif? ( media-libs/libexif )
	media-libs/tiff
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	return 0
}

src_compile() {
	econf \
		`use_enable exif` \
		`use_enable opengl` || die "econf failed"

	myth_src_compile || die "compile failed"
}
