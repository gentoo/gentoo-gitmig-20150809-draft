# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/oxine/oxine-0.6.6.ebuild,v 1.1 2007/03/24 17:36:24 beandog Exp $

WANT_AUTOMAKE="1.9"
inherit eutils autotools

MY_P="${PN}-0.6"
S=${WORKDIR}/${MY_P}

DESCRIPTION="OSD frontend for xine"
HOMEPAGE="http://oxine.sourceforge.net/"
SRC_URI="mirror://sourceforge/oxine/${MY_P}.tar.gz
	mirror://sourceforge/oxine/${PN}-0_6_0-to-0_6_6.patch"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc64 x86"
SLOT="0"
IUSE="X curl debug dvb jpeg nls png polling lirc v4l joystick"

DEPEND="media-libs/xine-lib
	curl? ( net-misc/curl )
	joystick? ( media-libs/libjsw )
	jpeg? ( media-gfx/imagemagick
		media-libs/netpbm
		media-video/mjpegtools )
	lirc? ( app-misc/lirc )
	nls? ( virtual/libintl sys-devel/gettext )
	png? ( media-gfx/imagemagick
		media-libs/netpbm
		media-video/mjpegtools )
	X? ( || ( ( x11-libs/libXext x11-libs/libX11 ) <virtual/x11-7 ) )
	virtual/eject"

pkg_setup() {

	# Check for USE flag deps
	ewarn "Checking USE flags of dependencies .. this may take a moment"

	# Video4Linux support
	if use v4l && ! built_with_use media-libs/xine-lib v4l ; then
		eerror "Re-emerge xine-lib with the 'v4l' USE flag"
		REBUILD_DEPS=1
	fi

	# X
	if ! built_with_use media-libs/xine-lib X ; then
		eerror "Re-emerge xine-lib with the 'X' USE flag"
		REBUILD_DEPS=1
	fi

	# Image support
	if (use png || use jpeg ) && ! built_with_use media-libs/netpbm zlib ; then
		eerror "In order to enable image support, media-libs/netpbm must be"
		eerror "emerged with the 'zlib' USE flag"
		REBUILD_DEPS=1
	fi

	if (use png || use jpeg ) && ! built_with_use media-libs/netpbm png ; then
		eerror "To view PNG images, media-libs/netpbm must be emerged with"
		eerror "the 'png' USE flag"
		REBUILD_DEPS=1
	fi

	if (use png || use jpeg ) && ! built_with_use media-libs/netpbm jpeg ; then
		eerror "To view JPEG images, media-libs/netpbm must be emerged with"
		eerror "with the 'jpeg' USE flag"
		REBUILD_DEPS=1
	fi

	if [[ ${REBUILD_DEPS} = 1 ]]; then
		eerror "Check your USE flags, re-emerge the dependencies and then"
		eerror "emerge this package."
		die
	fi

}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${PN}-0_6_0-to-0_6_6.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {

	# Note: Initial testing on amd64 indicates that the build will break
	# on --disable-curltest or --disable-xinetest so don't enable them
	# if debug is set.

	# Note on images: Image support will be automatically disabled if
	# netpbm, imagemagick or mjpegtools is not installed, irregardless
	# of what the USE flags are set to.

	# If one of the image USE flags is unset, disable image support
	if use !png && use !jpeg ; then
		myconf="${myconf} --disable-images"
	fi

	econf ${myconf} \
		$( use_with X x ) \
		$( use_with curl ) \
		$( use_enable curl curltest ) \
		$( use_enable debug ) \
		$( use_enable dvb ) \
		$( use_enable joystick ) \
		$( use_enable lirc ) \
		$( use_enable nls ) \
		$( use_enable polling ) \
		$( use_enable v4l ) \
		--disable-rpath --disable-weather || die "econf died"
	emake || die "emake failed"
}

src_install() {

	emake DESTDIR="${D}" install || die "emake install died"

	dodoc AUTHORS ChangeLog NEWS README TODO
	dohtml doc/doc.html

}
