# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgallery/mythgallery-0.18.1.ebuild,v 1.1 2005/05/20 09:05:34 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="Gallery and slideshow module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="opengl exif"

DEPEND="opengl? ( virtual/opengl )
	exif? ( media-libs/libexif )
	media-libs/tiff
	~media-tv/mythtv-${PV}"

MTVCONF="$(use_enable exif) $(use_enable opengl)"
