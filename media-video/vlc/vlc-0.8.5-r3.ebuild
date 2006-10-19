# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.8.5-r3.ebuild,v 1.11 2006/10/19 17:25:26 flameeyes Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit eutils wxwidgets multilib autotools toolchain-funcs gnome2

RESTRICT="confcache"

MY_P="${P/_beta/-test}"

PATCHLEVEL="25"
DESCRIPTION="VLC media player - Video player and streamer"
HOMEPAGE="http://www.videolan.org/vlc/"

[[ ${MY_P} != "${P}" ]] && \
	SRC_URI="http://download.videolan.org/pub/videolan/testing/${MY_P}/${MY_P}.tar.bz2" \
	|| SRC_URI="http://download.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"

SRC_URI="${SRC_URI}
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="a52 3dfx debug altivec httpd vlm gnutls live v4l cdda ogg matroska
dvb dvd vcd ffmpeg dts flac mpeg vorbis theora X opengl truetype svg fbcon svga
oss aalib ggi libcaca esd arts alsa wxwindows ncurses xosd lirc stream
mp3 xv bidi sdl png xml samba daap corba mod speex shout rtsp
win32codecs skins hal avahi xinerama cddb directfb upnp"

RDEPEND="cdda? ( >=dev-libs/libcdio-0.71
			cddb? ( >=media-libs/libcddb-1.2.0 ) )
		live? ( >=media-plugins/live-2005.01.29 )
		dvd? (	media-libs/libdvdread
				media-libs/libdvdcss
				>=media-libs/libdvdnav-0.1.9
				media-libs/libdvdplay )
		esd? ( media-sound/esound )
		ogg? ( media-libs/libogg )
		matroska? (
			>=dev-libs/libebml-0.7.6
			>=media-libs/libmatroska-0.7.5 )
		mp3? ( media-libs/libmad )
		ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20050226-r1 )
		a52? ( >=media-libs/a52dec-0.7.4-r3 )
		dts? ( >=media-libs/libdts-0.0.2-r3 )
		flac? ( ~media-libs/flac-1.1.2 )
		mpeg? ( >=media-libs/libmpeg2-0.3.2 )
		vorbis? ( media-libs/libvorbis )
		theora? ( media-libs/libtheora )
		truetype? ( media-libs/freetype
			media-fonts/ttf-bitstream-vera )
		svga? ( media-libs/svgalib )
		ggi? ( media-libs/libggi )
		aalib? ( media-libs/aalib )
		libcaca? ( media-libs/libcaca )
		arts? ( kde-base/arts )
		alsa? ( media-libs/alsa-lib )
		wxwindows? ( >=x11-libs/wxGTK-2.6.2-r1 )
		ncurses? ( sys-libs/ncurses )
		xosd? ( x11-libs/xosd )
		lirc? ( app-misc/lirc )
		3dfx? ( media-libs/glide-v3 )
		bidi? ( >=dev-libs/fribidi-0.10.4 )
		gnutls? ( >=net-libs/gnutls-1.0.17 )
		sys-libs/zlib
		png? ( media-libs/libpng )
		media-libs/libdvbpsi
		sdl? ( >=media-libs/libsdl-1.2.8 )
		xml? ( dev-libs/libxml2 )
		samba? ( net-fs/samba )
		vcd? ( >=dev-libs/libcdio-0.72
			>=media-video/vcdimager-0.7.21 )
		daap? ( >=media-libs/libopendaap-0.3.0 )
		corba? ( >=gnome-base/orbit-2.8.0
			>=dev-libs/glib-2.3.2 )
		v4l? ( sys-kernel/linux-headers )
		dvb? ( sys-kernel/linux-headers )
		mod? ( media-libs/libmodplug )
		speex? ( media-libs/speex )
		svg? ( >=gnome-base/librsvg-2.5.0 )
		shout? ( media-libs/libshout )
		win32codecs? ( media-libs/win32codecs )
		hal? ( sys-apps/hal )
		avahi? ( >=net-dns/avahi-0.6 )
		X? ( || ( (
				x11-libs/libX11
				x11-libs/libXext
				xv? ( x11-libs/libXv )
				xinerama? ( x11-libs/libXinerama )
			) <virtual/x11-7 )
			opengl? ( virtual/opengl )
		)
		directfb? ( dev-libs/DirectFB )
		upnp? ( >=net-misc/upnp-1.2 )"

DEPEND="${RDEPEND}
	X? ( xinerama? ( || ( x11-proto/xineramaproto <virtual/x11-7 ) ) )
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use wxwindows; then
		WX_GTK_VER="2.6"
		need-wxwidgets unicode || die "You need to install wxGTK with unicode support."
	fi

	if use skins && ! use truetype; then
		eerror "Trying to build with skins support but without truetype."
		die "You have to use 'truetype' to use 'skins'"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"
	AT_M4DIR="m4" eautoreconf
}

src_compile () {
	use wxwindows && \
		myconf="${myconf} --with-wx-config=$(basename ${WX_CONFIG}) --with-wx-config-path=$(dirname ${WX_CONFIG})"

	use vlm && \
		myconf="${myconf} --enable-vlm --enable-sout" || \
		myconf="${myconf} --disable-vlm"

	if use directfb; then
		myconf="${myconf} --enable-directfb --with-directfb=/usr"
		append-flags "-I /usr/include/directfb"
	else
		myconf="${myconf} --disable-directfb"
	fi

	econf \
		$(use_enable altivec) \
		$(use_enable stream sout) \
		$(use_enable httpd) \
		$(use_enable gnutls) \
		$(use_enable v4l) \
		$(use_enable cdda) $(use_enable cdda cddax)\
		$(use_enable cddb libcddb) \
		$(use_enable vcd) $(use_enable vcd vcdx) \
		$(use_enable dvb) $(use_enable dvb pvr) \
		$(use_enable ogg) \
		$(use_enable matroska mkv) \
		$(use_enable flac) \
		$(use_enable vorbis) \
		$(use_enable theora) \
		$(use_enable X x11) \
		$(use_enable xv xvideo) \
		$(use_enable xinerama) \
		$(use_enable opengl glx) $(use_enable opengl) \
		$(use_enable truetype freetype) \
		$(use_enable bidi fribidi) \
		$(use_enable dvd dvdread) $(use_enable dvd dvdplay) $(use_enable dvd dvdnav) \
		$(use_enable fbcon fb) \
		$(use_enable svga svgalib) \
		$(use_enable 3dfx glide) \
		$(use_enable aalib aa) \
		$(use_enable libcaca caca) \
		$(use_enable oss) \
		$(use_enable esd) \
		$(use_enable arts) \
		$(use_enable alsa) \
		$(use_enable wxwindows wxwidgets) \
		$(use_enable ncurses) \
		$(use_enable xosd) \
		$(use_enable lirc) \
		$(use_enable live livedotcom) $(use_with live livedotcom-tree /usr/lib/live) \
		$(use_enable mp3 mad) \
		$(use_enable a52) \
		$(use_enable dts) \
		$(use_enable mpeg libmpeg2) \
		$(use_enable ggi) \
		$(use_enable 3dfx glide) \
		$(use_enable sdl) \
		$(use_enable png) \
		$(use_enable xml libxml2) \
		$(use_enable samba smb) \
		$(use_enable daap) \
		$(use_enable corba) \
		$(use_enable mod) \
		$(use_enable speex) \
		$(use_enable shout) \
		$(use_enable rtsp) $(use_enable rtsp realrtsp) \
		$(use_enable win32codecs loader) \
		$(use_enable skins skins2) \
		$(use_enable hal) \
		$(use_enable avahi bonjour) \
		$(use_enable ffmpeg) \
		$(use_enable upnp) \
		--disable-mozilla \
		--disable-faad \
		--disable-jack \
		--disable-dv \
		--disable-libvc1 \
		--disable-snapshot \
		--disable-growl \
		--disable-pth \
		--disable-portaudio \
		--disable-x264 \
		--enable-utf8 \
		${myconf} || die "configuration failed"

	if [[ $(gcc-major-version) == 2 ]]; then
		sed -i -e s:"-fomit-frame-pointer":: vlc-config || die "-fomit-frame-pointer patching failed"
	fi

	emake || die "make of VLC failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed!"

	dodoc AUTHORS MAINTAINERS HACKING THANKS TODO NEWS README \
		doc/fortunes.txt doc/intf-cdda.txt doc/intf-vcd.txt

	rm -rf ${D}/usr/share/doc/vlc \
		${D}/usr/share/vlc/vlc{16x16,32x32,48x48,128x128}.{png,xpm,ico}

	use skins || rm -rf ${D}/usr/share/vlc/skins2

	for res in 16 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins ${S}/share/vlc${res}x${res}.png vlc.png
	done

	use wxwindows && domenu "${S}/debian/vlc.desktop"
}
