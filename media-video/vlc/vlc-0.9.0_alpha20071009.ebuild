# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.9.0_alpha20071009.ebuild,v 1.4 2007/10/10 11:08:21 aballier Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest

inherit eutils wxwidgets multilib autotools toolchain-funcs gnome2 nsplugins

MY_PV="${PV/_/-}"
MY_PV="${MY_PV/-beta/-test}"
MY_P="${PN}-${MY_PV}"
VLC_SNAPSHOT_TIME="0016"

# Used for live ebuilds
# ESVN_REPO_URI="svn://svn.videolan.org/vlc/trunk"
# ESVN_PROJECT="${PN}-trunk"
# ESVN_BOOTSTRAP="bootstrap"
# ESVN_PATCHES="${WORKDIR}/patches/*.patch"

PATCHLEVEL="42"
DESCRIPTION="VLC media player - Video player and streamer"
HOMEPAGE="http://www.videolan.org/vlc/"
if [[ "${P}" == *_alpha* ]]; then # Snapshots taken from nightlies.videolan.org
	SRC_URI="http://nightlies.videolan.org/build/source/trunk-${PV/*_alpha/}-${VLC_SNAPSHOT_TIME}/${PN}-snapshot-${PV/*_alpha/}.tar.bz2"
	MY_P="${P/_alpha*/}-svn"
elif [[ "${P}" == *_p* ]]; then # Snapshots
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
	MY_P="${P}"
elif [[ "${MY_P}" == "${P}" ]]; then
	SRC_URI="http://download.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"
else
	SRC_URI="http://download.videolan.org/pub/videolan/testing/${MY_P}/${MY_P}.tar.bz2"
fi

SRC_URI="${SRC_URI}
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="a52 3dfx debug altivec httpd vlm gnutls live v4l v4l2 cdda ogg matroska
dvb dvd vcd vcdx dts flac mpeg vorbis theora X opengl truetype svg fbcon svga
oss aalib ggi libcaca esd arts alsa wxwindows ncurses xosd lirc stream
mp3 xv bidi sdl sdl-image png xml samba daap mod speex shout rtsp
win32codecs skins hal avahi xinerama cddb directfb upnp nsplugin seamonkey
optimisememory libnotify jack musepack x264 dc1394 lua gnome pvr taglib
musicbrainz dbus libgcrypt id3tag cdio ffmpeg twolame xulrunner"

RDEPEND="
		ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20050226-r1 )
		cdda? ( >=dev-libs/libcdio-0.72
			cddb? ( >=media-libs/libcddb-1.2.0 ) )
		live? ( >=media-plugins/live-2007.02.20 )
		dvd? (	media-libs/libdvdread
				media-libs/libdvdcss
				>=media-libs/libdvdnav-0.1.9
				media-libs/libdvdplay )
		esd? ( media-sound/esound )
		ogg? ( media-libs/libogg )
		matroska? (
			>=dev-libs/libebml-0.7.6
			>=media-libs/libmatroska-0.8.0 )
		mp3? ( media-libs/libmad )
		a52? ( >=media-libs/a52dec-0.7.4-r3 )
		dts? ( media-libs/libdca )
		flac? ( media-libs/libogg
			>=media-libs/flac-1.1.2 )
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
		gnutls? ( >=net-libs/gnutls-1.3.3 )
		sys-libs/zlib
		png? ( media-libs/libpng )
		media-libs/libdvbpsi
		sdl? ( >=media-libs/libsdl-1.2.8
			sdl-image? ( media-libs/sdl-image ) )
		xml? ( dev-libs/libxml2 )
		samba? ( net-fs/samba )
		cdio? ( >=dev-libs/libcdio-0.78.2
			>=media-video/vcdimager-0.7.22 )
		daap? ( >=media-libs/libopendaap-0.3.0 )
		v4l? ( sys-kernel/linux-headers )
		v4l2? ( sys-kernel/linux-headers )
		dvb? ( sys-kernel/linux-headers )
		mod? ( media-libs/libmodplug )
		speex? ( media-libs/speex )
		svg? ( >=gnome-base/librsvg-2.9.0 )
		shout? ( media-libs/libshout )
		win32codecs? ( media-libs/win32codecs )
		hal? ( sys-apps/hal )
		avahi? ( >=net-dns/avahi-0.6 )
		X? (
			x11-libs/libX11
			x11-libs/libXext
			xv? ( x11-libs/libXv )
			xinerama? ( x11-libs/libXinerama )
			opengl? ( virtual/opengl )
		)
		directfb? ( dev-libs/DirectFB )
		upnp? ( net-libs/libupnp )
		nsplugin? (
			xulrunner? ( net-libs/xulrunner )
			!xulrunner? ( seamonkey? ( www-client/seamonkey ) )
			!xulrunner? ( !seamonkey? ( www-client/mozilla-firefox ) )
		)
		libnotify? ( x11-libs/libnotify )
		musepack? ( media-libs/libmpcdec )
		x264? ( >=media-libs/x264-svn-20061014 )
		jack? ( >=media-sound/jack-audio-connection-kit-0.99.0-r1 )
		lua? ( >=dev-lang/lua-5.1 )
		gnome? ( gnome-base/gnome-vfs )
		taglib? ( media-libs/taglib )
		musicbrainz? ( media-libs/musicbrainz )
		dc1394? ( sys-libs/libraw1394
			<media-libs/libdc1394-1.9.99 )
		dbus? ( >=sys-apps/dbus-1.0.2 )
		libgcrypt? ( >=dev-libs/libgcrypt-1.2.0 )
		id3tag? ( media-libs/libid3tag
			sys-libs/zlib )
		twolame? ( media-sound/twolame )"

# Disabled features and reasons : 
# xvmc? ( x11-libs/libXvMC )
#	Will probably compile only on x86
# dirac? ( media-video/dirac )
#	Needs testing but can be ok
# qt4? ( $(qt4_min_version 4.2.0 ) )
#	Main addition of 0.9.0, will enable it when it'll be released
# zvbi? ( >=media-libs/zvbi-0.2.25 )
#	Dep not up to date enough


# libgcrypt is mandatory at buildtime, and that's not only a matter of missing
# m4s. Bug #195322
DEPEND="${RDEPEND}
	X? ( xinerama? ( x11-proto/xineramaproto ) )
	dev-util/pkgconfig
	>=dev-libs/libgcrypt-1.2.0"

S="${WORKDIR}/${MY_P}"

# Block older versions, we can't upgrade cleanly until bug #157746 gets
# resolved...
RDEPEND="${RDEPEND}
	!<media-video/vlc-0.8.8"
DEPEND="${DEPEND}
	!<media-video/vlc-0.8.8"



# Dispalys a warning if the first use flag is set but not the second
vlc_use_needs() {
	use $1 && use !$2 && ewarn "USE=$1 requires $2, $1 will be disabled."
}

pkg_setup() {
	if use wxwindows || use skins; then
		WX_GTK_VER="2.6"
		need-wxwidgets unicode || die "You need to install wxGTK with unicode support."
	fi
	vlc_use_needs skins truetype
	vlc_use_needs skins wxwindows
	vlc_use_needs cdda cdio
	vlc_use_needs vcdx cdio
	vlc_use_needs libgcrypt gnutls
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"
	AT_M4DIR="m4" eautoreconf
}

src_compile () {
	local XPIDL=""
	local MOZILLA_CONFIG=""

	use vlm && \
		myconf="${myconf} --enable-vlm --enable-sout" || \
		myconf="${myconf} --disable-vlm"

	if use nsplugin; then
		if use xulrunner; then
			XPIDL=/usr/$(get_libdir)/xulrunner
			MOZILLA_CONFIG=/usr/bin/xulrunner-config
		elif use seamonkey; then
			XPIDL=/usr/$(get_libdir)/seamonkey
			MOZILLA_CONFIG=/usr/$(get_libdir)/seamonkey/seamonkey-config
		else
			XPIDL=/usr/$(get_libdir)/mozilla-firefox
			MOZILLA_CONFIG=/usr/$(get_libdir)/mozilla-firefox/firefox-config
		fi
	fi

	econf \
		$(use_enable altivec) \
		$(use_enable stream sout) \
		$(use_enable httpd) \
		$(use_enable gnutls) \
		$(use_enable v4l) \
		$(use_enable v4l2) \
		$(use_enable cdda) $(use_enable cdda cddax)\
		$(use_enable cddb libcddb) \
		$(use_enable vcd) \
		$(use_enable vcdx vcdx) \
		$(use_enable dvb) \
		$(use_enable pvr) \
		$(use_enable ogg) \
		$(use_enable matroska mkv) \
		$(use_enable flac) \
		$(use_enable vorbis) \
		$(use_enable theora) \
		$(use_enable X x11) \
		$(use_enable X screen) \
		$(use_enable xv xvideo) \
		$(use_enable directfb) \
		--disable-xvmc \
		$(use_enable xinerama) \
		$(use_enable opengl glx) $(use_enable opengl) $(use_enable opengl galaktos) \
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
		$(use_enable ncurses) \
		$(use_enable xosd) \
		$(use_enable lirc) \
		$(use_enable mp3 mad) \
		$(use_enable a52) \
		$(use_enable dts dca) \
		$(use_enable mpeg libmpeg2) \
		$(use_enable ggi) \
		$(use_enable 3dfx glide) \
		$(use_enable sdl) \
		$(use_enable sdl-image) \
		$(use_enable png) \
		$(use_enable xml libxml2) \
		$(use_enable samba smb) \
		$(use_enable daap) \
		$(use_enable mod) \
		$(use_enable speex) \
		$(use_enable shout) \
		$(use_enable rtsp) $(use_enable rtsp realrtsp) \
		$(use_enable win32codecs loader) \
		$(use_enable skins skins2) \
		$(use_enable hal) \
		$(use_enable avahi bonjour) \
		$(use_enable upnp) \
		$(use_enable optimisememory optimize-memory) \
		$(use_enable libnotify notify) \
		$(use_enable jack) \
		$(use_enable musepack mpc) \
		$(use_enable x264) \
		$(use_enable dc1394) \
		--disable-qt4 \
		$(use_enable lua) \
		$(use_enable gnome gnomevfs) \
		$(use_enable taglib) \
		$(use_enable musicbrainz) \
		--disable-dirac \
		$(use_enable dbus) $(use_enable dbus dbus-control) \
		$(use_enable libgcrypt) \
		--disable-zvbi \
		$(use_enable id3tag) \
		$(use_enable live live555) \
		$(use_enable cdio libcdio) \
		$(use_enable truetype freetype) \
		$(use_enable wxwindows wxwidgets) \
		$(use_enable ffmpeg) \
		$(use_enable twolame) \
		--disable-faad \
		--disable-dv \
		--disable-libvc1 \
		--disable-snapshot \
		--disable-growl \
		--disable-pth \
		--disable-portaudio \
		--disable-libtar \
		--disable-optimizations \
		--enable-utf8 \
		--enable-libtool \
		--enable-fast-install \
		$(use_enable nsplugin mozilla) \
		XPIDL="${XPIDL}" MOZILLA_CONFIG="${MOZILLA_CONFIG}" \
		WX_CONFIG="${WX_CONFIG}" \
		${myconf} || die "configuration failed"

	if [[ $(gcc-major-version) == 2 ]]; then
		sed -i -e s:"-fomit-frame-pointer":: vlc-config || die "-fomit-frame-pointer patching failed"
	fi

	emake || die "make of VLC failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS MAINTAINERS HACKING THANKS NEWS README \
		doc/fortunes.txt doc/intf-cdda.txt doc/intf-vcd.txt

	rm -rf "${D}/usr/share/doc/vlc" \
		"${D}"/usr/share/vlc/vlc{16x16,32x32,48x48,128x128}.{png,xpm,ico}

	if use nsplugin; then
		dodir "/usr/$(get_libdir)/${PLUGINS_DIR}"
		mv "${D}"/usr/$(get_libdir)/mozilla/plugins/* \
			"${D}/usr/$(get_libdir)/${PLUGINS_DIR}/"
	fi

	use skins || rm -rf "${D}/usr/share/vlc/skins2"

	for res in 16 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins "${S}"/share/vlc${res}x${res}.png vlc.png
	done

	use wxwindows || rm "${D}/usr/share/applications/vlc.desktop"
}
