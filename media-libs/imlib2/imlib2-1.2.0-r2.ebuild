# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.2.0-r2.ebuild,v 1.6 2006/02/09 23:45:35 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment multilib

MY_P=${P/_/-}
DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="http://www.enlightenment.org/Libraries/Imlib2.html"

IUSE="X gif jpeg mmx png tiff"

DEPEND="=media-libs/freetype-2*
	gif? ( >=media-libs/giflib-4.1.0 )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( media-libs/jpeg )
	tiff? ( >=media-libs/tiff-3.5.5 )
	X? ( || ( ( x11-libs/libXext x11-proto/xextproto ) virtual/x11 ) )"

src_unpack() {
	enlightenment_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${P}-loaders.patch
	epatch "${FILESDIR}"/imlib-1.2.0-bounds-check.patch
	# uClibc doesnt have lround() and upstream changed to round() ...
	sed -i \
		-e 's:lround:round:' \
		src/lib/color_helpers.c || die
}

src_compile() {
	local mymmx=""
	if [ "${ARCH}" == "amd64" ] ; then
		mymmx="--disable-mmx"
	else
		mymmx="$(use_enable mmx)"
	fi

	export MY_ECONF="
		${mymmx} \
		$(use_enable X x11) \
	"
	enlightenment_src_compile
}

src_install() {
	enlightenment_src_install
	dosed "s:@requirements@::" /usr/$(get_libdir)/pkgconfig/imlib2.pc
	docinto samples
	dodoc demo/*.c
}
