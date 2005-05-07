# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.0.53.ebuild,v 1.1 2005/05/07 19:37:06 rphillips Exp $

inherit fox

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~ia64 ~ppc ~ppc64 ~sparc"
IUSE="cups jpeg opengl png tiff zlib"

RDEPEND="virtual/x11
	cups? ( net-print/cups )
	jpeg? ( >=media-libs/jpeg-6b )
	opengl? ( virtual/opengl )
	png? ( >=media-libs/libpng-1.2.5 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	zlib? ( >=sys-libs/zlib-1.1.4 )"

FOXCONF="$(use_enable cups) \
	$(use_enable jpeg) \
	$(use_enable png) \
	$(use_enable tiff) \
	$(use_enable zlib)"

# fox-1.0 incorrectly detects mesa on xorg-x11-6.8.2
use opengl \
	&& FOXCONF="${FOXCONF} --with-opengl=opengl" \
	|| FOXCONF="${FOXCONF} --without-opengl"
