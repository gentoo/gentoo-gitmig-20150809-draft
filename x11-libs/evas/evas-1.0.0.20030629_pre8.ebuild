# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/evas/evas-1.0.0.20030629_pre8.ebuild,v 1.1 2003/06/29 17:47:04 vapier Exp $

inherit flag-o-matic

DESCRIPTION="hardware-accelerated canvas API"
HOMEPAGE="http://www.enlightenment.org/pages/evas.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE="X mmx opengl jpeg png directfb fbcon"

DEPEND="virtual/x11
	>=media-libs/imlib2-1.0.6.2003*
	>=dev-libs/eet-0.0.1.2003*
	>=dev-db/edb-1.0.3.2003*
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	directfb? ( >=dev-libs/DirectFB-0.9.16 )
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_compile() {
	env NOCONFIGURE=yes ./autogen.sh || die "could not autogen"

	# other *very* fun options:
	# (just do `env EXTRA_CONF="--enable-cpu-sse" emerge evas`)
	#  --enable-cpu-p2-only            enable assumption of pentium2/amd cpu
	#  --enable-cpu-p3-only            enable assumption of pentium3 and up cpu
	#  --enable-cpu-sse                enable sse code
	#  --enable-scale-sample           enable sampling scaler code
	#  --enable-scale-smooth           enable sampling scaler code
	#  --enable-scale-trilinear        enable tri-linear scaler code

	local myconf=""
	# mmx causes segfaults atm :/
#	use mmx		&& myconf="${myconf} --enable-cpu-mmx"
	use X		&& myconf="${myconf} --enable-software-x11"
	use opengl	&& myconf="${myconf} --enable-gl-x11"
	use directfb	&& myconf="${myconf} --enable-directfb"
	use fbcon	&& myconf="${myconf} --enable-fb"

	use alpha	&& append-flags -fPIC

	econf \
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
		--enable-convert-8-rgb-121 \
		--enable-convert-8-rgb-111 \
		--enable-convert-16-rgb-565 \
		--enable-convert-16-rgb-555 \
		--enable-convert-16-rgb-rot-0 \
		--enable-convert-32-rgb-8888 \
		--enable-convert-32-rgbx-8888 \
		--enable-convert-32-bgr-8888 \
		--enable-convert-32-bgrx-8888 \
		--enable-convert-32-rgb-rot-0 \
		`use_enable png image-loader-png` \
		`use_enable jpeg image-loader-jpeg` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS ChangeLog Doxyfile NEWS README TODO
	dohtml -r doc
}
