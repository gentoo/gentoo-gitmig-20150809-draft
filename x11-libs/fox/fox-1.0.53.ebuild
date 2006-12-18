# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.0.53.ebuild,v 1.6 2006/12/18 09:13:37 mr_bones_ Exp $

inherit toolchain-funcs flag-o-matic fox

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~ia64 ~ppc ~ppc64 ~sparc"
IUSE="cups jpeg opengl png tiff zlib"

RDEPEND="x11-libs/libXrandr
	x11-libs/libXcursor
	cups? ( net-print/cups )
	jpeg? ( >=media-libs/jpeg-6b )
	opengl? ( virtual/opengl virtual/glu )
	png? ( >=media-libs/libpng-1.2.5 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	zlib? ( >=sys-libs/zlib-1.1.4 )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-libs/libXt"

FOXCONF="$(use_enable cups) \
	$(use_enable jpeg) \
	$(use_enable png) \
	$(use_enable tiff) \
	$(use_enable zlib)"

# fox-1.0 incorrectly detects mesa on xorg-x11-6.8.2
use opengl \
	&& FOXCONF="${FOXCONF} --with-opengl=opengl" \
	|| FOXCONF="${FOXCONF} --without-opengl"

src_compile() {
	if [[ $(gcc-major-version) -ge 4 ]]; then
		append-flags -ffriend-injection
	fi
	fox_src_compile
}
