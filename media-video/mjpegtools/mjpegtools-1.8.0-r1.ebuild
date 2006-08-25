# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.8.0-r1.ebuild,v 1.18 2006/08/25 13:45:53 zzam Exp $

inherit flag-o-matic toolchain-funcs eutils libtool autotools

DESCRIPTION="Tools for MJPEG video"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${P}.tar.gz"

LICENSE="as-is"
SLOT="1"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="gtk dv quicktime sdl X yv12 3dnow mmx sse v4l dga png"

RDEPEND="media-libs/jpeg
	x86? ( media-libs/libmovtar
		mmx? ( >=media-libs/jpeg-mmx-0.1.6 )
	)
	gtk? ( =x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )
	dv? ( >=media-libs/libdv-0.99 )
	quicktime? ( virtual/quicktime )
	png? ( media-libs/libpng )
	sdl? ( >=media-libs/libsdl-1.2.7-r3 )
	X? ( || ( ( x11-libs/libX11
				x11-libs/libXt
			)
			virtual/x11
		)
	)"

DEPEND="${RDEPEND}
	x86? ( mmx? ( dev-lang/nasm )
		3dnow? ( dev-lang/nasm )
		sse? ( dev-lang/nasm )
		)
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/ARCHFLAGS=/s:=.*:=:' configure

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-parallelmake.patch"
	epatch "${FILESDIR}/${P}-pkg-config.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	has_version ">=media-libs/libquicktime-0.9.9" && epatch "${FILESDIR}/${P}-libquicktime.patch"

	# eautoreconf instead of elibtoolize
	# as pkg-config-patch changes configure.in
	eautoreconf
}

src_compile() {
	local myconf

	if use yv12 && use dv; then
		myconf="${myconf} --with-dv-yv12"
	elif use yv12; then
		ewarn "yv12 support is possible when 'dv' is in your USE flags."
	fi

	# This could be changed to allow building on g/fbsd in the future.
	if use x86; then
		if use mmx || use 3dnow || use sse; then
			myconf="${myconf} --enable-simd-accel"
		fi
		if use mmx; then
			myconf="${myconf} --with-jpeg-mmx=/usr/include/jpeg-mmx"
		fi

		if [[ ${CHOST/i686/} != ${CHOST} ]] || [[ ${CHOST/x86_64/} != ${CHOST} ]]; then
			myconf="${myconf} --enable-cmov-extension"
		fi

		[[ $(gcc-major-version) -eq 3 ]] && append-flags -mno-sse2
	fi

	if use amd64; then
		myconf="${myconf} --enable-simd-accel"
		myconf="${myconf} --enable-cmov-extension"
	fi

	append-flags -fno-strict-aliasing

	econf \
		$(use_with X x) \
		$(use_enable dga xfree-ext) \
		$(use_with quicktime libquicktime) \
		$(use_with png libpng) \
		$(use_with v4l) \
		$(use_with gtk) \
		$(use_with sdl) \
		$(use_with dv dv /usr) \
		--enable-largefile \
		${myconf} || die "configure failed"

	emake || die "emake failed"

	cd docs
	local infofile
	for infofile in mjpeg*info*; do
		echo "INFO-DIR-SECTION Miscellaneous" >> ${infofile}
		echo "START-INFO-DIR-ENTRY" >> ${infofile}
		echo "* mjpeg-howto: (mjpeg-howto).					 How to use the mjpeg-tools" >> ${infofile}
		echo "END-INFO-DIR-ENTRY" >> ${infofile}
	done
}

src_install() {
	einstall || die "install failed"
	dodoc mjpeg_howto.txt README PLANS NEWS README.AltiVec README.avilib \
		README.DV README.glav README.lavpipe README.transist TODO \
		HINTS BUGS ChangeLog AUTHORS CHANGES
}
