# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.2.18.ebuild,v 1.1 2006/08/23 00:16:45 dberkholz Exp $

inherit toolchain-funcs flag-o-matic fox

LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~ppc ~ppc64 ~sparc"
IUSE="bzip2 cups jpeg opengl png threads tiff truetype zlib"

RDEPEND="|| ( ( x11-libs/libXrandr
			x11-libs/libXcursor
		)
		virtual/x11
	)
	x11-libs/fox-wrapper
	bzip2? ( >=app-arch/bzip2-1.0.2 )
	cups? ( net-print/cups )
	jpeg? ( >=media-libs/jpeg-6b )
	opengl? ( virtual/opengl virtual/glu )
	png? ( >=media-libs/libpng-1.2.5 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	truetype? ( =media-libs/freetype-2*
		virtual/xft )
	zlib? ( >=sys-libs/zlib-1.1.4 )"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto
			x11-libs/libXt
		)
		virtual/x11
	)"

FOXCONF="$(use_enable bzip2 bz2lib) \
	$(use_enable cups) \
	$(use_enable jpeg) \
	$(use_with opengl) \
	$(use_enable png) \
	$(use_enable threads threadsafe) \
	$(use_enable tiff) \
	$(use_with truetype xft) \
	$(use_enable zlib)"

src_compile() {
	if [[ $(gcc-major-version) -ge 4 ]]; then
		append-flags -ffriend-injection
	fi
	fox_src_compile
}
