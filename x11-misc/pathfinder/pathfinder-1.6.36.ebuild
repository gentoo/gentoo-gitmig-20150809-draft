# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pathfinder/pathfinder-1.6.36.ebuild,v 1.5 2010/07/27 01:34:56 jer Exp $

EAPI="1"

inherit fox

DESCRIPTION="File manager based on the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ppc ppc64 ~sparc x86"
IUSE="jpeg png tiff"

DEPEND="x11-libs/fox:1.6
	jpeg? ( >=media-libs/jpeg-6b )
	png? ( >=media-libs/libpng-1.2.5 )
	tiff? ( >=media-libs/tiff-3.5.7 )"

RDEPEND="${DEPEND}"

FOXCONF="$(use_enable jpeg) \
	$(use_enable png) \
	$(use_enable tiff)"
