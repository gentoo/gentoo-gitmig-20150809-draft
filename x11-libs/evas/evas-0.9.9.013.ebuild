# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/evas/evas-0.9.9.013.ebuild,v 1.1 2005/08/20 05:23:06 vapier Exp $

inherit enlightenment

DESCRIPTION="hardware-accelerated canvas API"

IUSE="X directfb fbcon jpeg mmx opengl png sse cairo"

DEPEND="virtual/x11
	>=media-libs/imlib2-1.2.0
	>=dev-libs/eet-0.9.9
	>=dev-db/edb-1.0.5
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	directfb? ( >=dev-libs/DirectFB-0.9.16 )
	cairo? ( >=x11-libs/cairo-0.2.0 )
	dev-util/pkgconfig"

src_compile() {
	# other *very* fun options:
	#  --enable-cpu-p2-only            enable assumption of pentium2/amd cpu
	#  --enable-cpu-p3-only            enable assumption of pentium3 and up cpu
	#  --enable-cpu-mmx                enable mmx code
	#  --enable-cpu-sse                enable sse code
	#  --enable-scale-sample           enable sampling scaler code
	#  --enable-scale-smooth           enable sampling scaler code
	#  --enable-scale-trilinear        enable tri-linear scaler code
	export MY_ECONF="
		$(use_enable cairo cairo-x11)
		$(use_enable mmx cpu-mmx) \
		$(use_enable sse cpu-mmx) \
		$(use_enable sse cpu-sse) \
		$(use_enable X software-x11) \
		$(use_enable opengl gl-x11) \
		$(use_enable directfb) \
		$(use_enable fbcon fb) \
		--enable-image-loader-eet \
		--enable-image-loader-edb \
		--enable-fmemopen \
		--enable-cpu-c \
		--enable-scale-smooth \
		--enable-scale-sample \
		--enable-convert-8-rgb-332 \
		--enable-convert-8-rgb-666 \
		--enable-convert-8-rgb-232 \
		--enable-convert-8-rgb-222 \
		--enable-convert-8-rgb-221 \
		--enable-convert-8-rgb-111 \
		--enable-convert-16-rgb-565 \
		--enable-convert-16-rgb-555 \
		--enable-convert-16-rgb-444 \
		--enable-convert-16-rgb-rot-0 \
		--enable-convert-16-rgb-rot-270 \
		--enable-convert-16-rgb-rot-90 \
		--enable-convert-24-rgb-888 \
		--enable-convert-24-bgr-888 \
		--enable-convert-32-rgb-8888 \
		--enable-convert-32-rgbx-8888 \
		--enable-convert-32-bgr-8888 \
		--enable-convert-32-bgrx-8888 \
		--enable-convert-32-rgb-rot-0 \
		--enable-convert-32-rgb-rot-270 \
		--enable-convert-32-rgb-rot-90 \
		$(use_enable png image-loader-png) \
		$(use_enable jpeg image-loader-jpeg)
	"
	enlightenment_src_compile
}
