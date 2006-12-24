# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgallery/mythgallery-0.20_p11188.ebuild,v 1.2 2006/12/24 07:56:11 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="Gallery and slideshow module for MythTV."
KEYWORDS="amd64 ppc x86"
IUSE="exif"

RDEPEND="exif? ( >=media-libs/libexif-0.6.10 )
	media-libs/tiff"
DEPEND="${RDEPEND}"

MTVCONF="$(use_enable exif) $(use_enable exif new-exif)"
