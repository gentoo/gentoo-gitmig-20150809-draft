# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.9.0.ebuild,v 1.1 2009/01/10 12:20:05 beandog Exp $

EAPI="1"

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit flag-o-matic toolchain-funcs eutils libtool

MY_P=${P/_/}

DESCRIPTION="Tools for MJPEG video"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk dv quicktime sdl X yv12 v4l dga png mmx"

RDEPEND="media-libs/jpeg
	gtk? ( x11-libs/gtk+:2 )
	dv? ( >=media-libs/libdv-0.99 )
	quicktime? ( virtual/quicktime )
	png? ( media-libs/libpng )
	sdl? ( >=media-libs/libsdl-1.2.7-r3 )
	X? ( x11-libs/libX11
		x11-libs/libXt )"

DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )
	>=sys-apps/sed-4
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
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
	dodoc mjpeg_howto.txt README* PLANS NEWS TODO HINTS BUGS ChangeLog \
		AUTHORS CHANGES
}
