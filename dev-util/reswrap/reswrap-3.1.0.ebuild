# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/reswrap/reswrap-3.1.0.ebuild,v 1.2 2009/09/23 17:48:09 patrick Exp $

FOX_COMPONENT="utils"
FOX_PV="1.2.15"

inherit fox

DESCRIPTION="Utility to wrap icon resources into C++ code, from the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~ppc ~ppc64 ~sparc"
IUSE=""

RDEPEND=""

FOXCONF="--disable-bz2lib \
	--disable-cups \
	--disable-jpeg \
	--without-opengl \
	--disable-png \
	--disable-tiff \
	--without-x \
	--without-xcursor \
	--without-xft \
	--without-xshm \
	--disable-zlib"
