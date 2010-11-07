# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.8.0-r2.ebuild,v 1.8 2010/11/07 19:15:03 anarchy Exp $

inherit flag-o-matic toolchain-funcs eutils libtool autotools

DESCRIPTION="Tools for MJPEG video"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${P}.tar.gz
	mirror://gentoo/${PN}-m4-1.tar.bz2"

LICENSE="as-is"
SLOT="1"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="gtk dv quicktime sdl X yv12 v4l dga png mmx"

RDEPEND="virtual/jpeg
	gtk? ( >=x11-libs/gtk+-2.0 )
	dv? ( >=media-libs/libdv-0.99 )
	quicktime? ( virtual/quicktime )
	png? ( media-libs/libpng )
	sdl? ( >=media-libs/libsdl-1.2.7-r3 )
	X? ( x11-libs/libX11
		x11-libs/libXt
	)"

DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )
	>=sys-apps/sed-4
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-parallelmake.patch"
	epatch "${FILESDIR}/${P}-pkg-config.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	has_version ">=media-libs/libquicktime-0.9.9" && epatch "${FILESDIR}/${P}-libquicktime.patch"
	epatch "${FILESDIR}/${P}-fix-lav2mpeg.patch"
	epatch "${FILESDIR}/${P}-lavrec-memleak.patch"
	epatch "${FILESDIR}/${P}-no-jpeg-mmx.patch"
	epatch "${FILESDIR}/${P}-libc.patch"
	epatch "${FILESDIR}/${P}-glibc-2.10.patch"

	# eautoreconf instead of elibtoolize
	# as pkg-config-patch changes configure.in
	#
	# use m4-files from additional tarball as mjpegtools the fails if
	# package providing m4-file is not installed
	AT_M4DIR=${WORKDIR}/m4 eautoreconf

	sed -i -e '/ARCHFLAGS=/s:=.*:=:' configure
}

src_compile() {
	local myconf

	if use yv12 && use dv; then
		myconf="${myconf} --with-dv-yv12"
	elif use yv12; then
		ewarn "yv12 support is possible when 'dv' is in your USE flags."
	fi

	[[ $(gcc-major-version) -eq 3 ]] && append-flags -mno-sse2

	append-flags -fno-strict-aliasing

	econf \
		$(use_with X x) \
		$(use_enable dga xfree-ext) \
		$(use_with quicktime libquicktime) \
		$(use_with png libpng) \
		$(use_with v4l) \
		$(use_with gtk) \
		$(use_with sdl) \
		$(use_with dv libdv /usr) \
		$(use_enable mmx simd-accel) \
		--enable-largefile \
		--without-jpeg-mmx \
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
