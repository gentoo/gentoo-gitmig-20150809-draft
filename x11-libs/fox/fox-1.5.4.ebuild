# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.5.4.ebuild,v 1.1 2005/05/07 19:37:06 rphillips Exp $

inherit fox

LICENSE="LGPL-2.1"
SLOT="1.5"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~ppc ~ppc64 ~sparc"
IUSE="bzlib cups jpeg opengl png threads tiff truetype zlib"

RDEPEND="virtual/x11
	x11-libs/fox-wrapper
	bzlib? ( >=app-arch/bzip2-1.0.2 )
	cups? ( net-print/cups )
	jpeg? ( >=media-libs/jpeg-6b )
	opengl? ( virtual/opengl )
	png? ( >=media-libs/libpng-1.2.5 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	truetype? ( =media-libs/freetype-2*
		virtual/xft )
	zlib? ( >=sys-libs/zlib-1.1.4 )"

FOXCONF="$(use_enable bzlib bz2lib) \
	$(use_enable cups) \
	$(use_enable jpeg) \
	$(use_with opengl) \
	$(use_enable png) \
	$(use_enable threads threadsafe) \
	$(use_enable tiff) \
	$(use_with truetype xft) \
	$(use_enable zlib)"
