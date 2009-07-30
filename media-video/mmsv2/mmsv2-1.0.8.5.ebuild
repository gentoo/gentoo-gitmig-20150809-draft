# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mmsv2/mmsv2-1.0.8.5.ebuild,v 1.3 2009/07/30 08:33:17 dirtyepic Exp $

inherit eutils toolchain-funcs

MY_P=${P/v2}

DESCRIPTION="Menu system for easy movie and audio playback and image viewing."
HOMEPAGE="http://mymediasystem.org"
SRC_URI="http://mms.sunsite.dk/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug dvb dxr3 fbcon gstreamer input_devices_evdev lirc minimal mpeg nls radio sdl svga xine"

RDEPEND="media-libs/imlib2
	dev-libs/libpcre
	media-libs/taglib
	=dev-db/sqlite-2.8*
	dev-cpp/commoncpp2
	x11-libs/libXScrnSaver
	dvb? ( media-tv/xmltv )
	svga? ( media-libs/svgalib )
	!xine? ( !gstreamer? ( media-sound/alsaplayer ) )
	!xine? ( gstreamer? ( >=media-libs/gstreamer-0.10 ) )
	xine? ( media-libs/xine-lib media-video/cxfe )
	lirc? ( app-misc/lirc )
	sdl? ( media-libs/libsdl )
	dxr3? ( media-video/em8300-libraries )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cc.patch
	epatch "${FILESDIR}"/${P}-gcc_compat.patch
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_compile() {
	local myconf="--prefix=/usr --use-internal-ffmpeg --enable-eject-tray"

	use minimal || myconf="${myconf} --enable-game"

	if use xine; then
		myconf="${myconf} --enable-xine-audio"
		einfo "Selecting xine instead of gstreamer or alsaplayer."
	elif use gstreamer; then
		myconf="${myconf} --enable-gst-audio"
		einfo "Selecting gstreamer instead of xine or alsaplayer."
	else
		einfo "Selecting alsaplayer instead of xine or gstreamer."
	fi

	if use fbcon; then
		myconf="${myconf} --enable-fbdev"
		ewarn "Enabling deprecated output fbdev, use sdl instead."
	fi

	if use radio; then
		myconf="${myconf} --enable-bttv-radio"
	else
		myconf="${myconf} --disable-radio"
	fi

	use svga && myconf="${myconf} --enable-vgagl"
	use lirc && myconf="${myconf} --enable-lirc"
	use input_devices_evdev && myconf="${myconf} --enable-evdev"
	use sdl || myconf="${myconf} --disable-sdl"
	use dxr3 && myconf="${myconf} --enable-dxr3"
	use dvb && myconf="${myconf} --enable-dvb --enable-tv"
	use mpeg && myconf="${myconf} --enable-mpeg"
	use nls || myconf="${myconf} --disable-nls"
	use debug && myconf="${myconf} --enable-debug --enable-benchmark"

	./configure ${myconf} || die "configure failed."

	emake CXX="$(tc-getCXX)" C="$(tc-getCC)" CC="$(tc-getCC)" \
		EXTRA_FLAGS="${CFLAGS}" OPTIMIZATION="" || die "emake failed."
}

src_install() {
	emake INSTALLSTRIP="" DESTDIR="${D}" install || die "emake install failed."
	dodoc doc/{CHANGELOG,README}
}
