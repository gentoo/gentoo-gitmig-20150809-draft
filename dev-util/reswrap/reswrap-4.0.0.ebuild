# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/reswrap/reswrap-4.0.0.ebuild,v 1.3 2012/02/24 19:23:07 ranger Exp $

FOX_COMPONENT="utils"
FOX_PV="1.6.40"

inherit fox

DESCRIPTION="Utility to wrap icon resources into C++ code, from the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""

FOXCONF="--disable-bz2lib \
	--disable-jpeg \
	--without-opengl \
	--disable-png \
	--without-shape \
	--disable-tiff \
	--without-x \
	--without-xcursor \
	--without-xrandr \
	--without-xshm \
	--without-xft \
	--disable-zlib"
