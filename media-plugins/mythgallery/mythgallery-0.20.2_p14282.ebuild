# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgallery/mythgallery-0.20.2_p14282.ebuild,v 1.1 2007/08/25 23:26:20 beandog Exp $

inherit mythtv-plugins subversion

DESCRIPTION="Gallery and slideshow module for MythTV."
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif"

RDEPEND="exif? ( >=media-libs/libexif-0.6.10 )
	media-libs/tiff"
DEPEND="${RDEPEND}"

MTVCONF="$(use_enable exif) $(use_enable exif new-exif)"
