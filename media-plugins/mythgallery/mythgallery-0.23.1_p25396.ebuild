# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgallery/mythgallery-0.23.1_p25396.ebuild,v 1.2 2011/07/08 15:18:08 cardoe Exp $

EAPI=2
inherit qt4 mythtv-plugins

DESCRIPTION="Gallery and slideshow module for MythTV."
KEYWORDS="amd64 ~ppc x86"
IUSE="+exif opengl"

RDEPEND="exif? ( >=media-libs/libexif-0.6.10 )
	opengl? ( virtual/opengl )
	media-libs/tiff"
DEPEND="${RDEPEND}"

MTVCONF="$(use_enable exif) $(use_enable exif new-exif) $(use_enable opengl)"
