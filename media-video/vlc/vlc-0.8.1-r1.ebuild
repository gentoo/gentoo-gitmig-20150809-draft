# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.8.1-r1.ebuild,v 1.2 2005/04/04 17:20:15 luckyduck Exp $

# Missing support for...
#	tarkin - package not in portage yet - experimental
#	tremor - package not in portage yet - experimental

inherit libtool gcc eutils wxwidgets

DESCRIPTION="VLC media player - Video player and streamer"
HOMEPAGE="http://www.videolan.org/vlc/"
SRC_URI="http://download.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="a52 3dfx nls unicode debug altivec httpd vlm gnutls live v4l cdio cddb cdda ogg matroska dvb dvd vcd ffmpeg aac dts flac mpeg oggvorbis theora X opengl freetype svg fbcon svga oss aalib ggi libcaca esd arts alsa wxwindows ncurses xosd lirc joystick mozilla hal stream mad xv bidi gtk2 sdl threads ssl portaudio"

DEPEND="hal? ( >=sys-apps/hal-0.2.97 )
		cdio? ( >=dev-libs/libcdio-0.70 )
		cddb? ( >=media-libs/libcddb-0.9.4 )
		live? ( >=media-plugins/live-2005.01.29 )
		dvd? (  media-libs/libdvdread
				media-libs/libdvdcss
				>=media-libs/libdvdnav-0.1.9
				media-libs/libdvdplay )
		esd? ( media-sound/esound )
		ogg? ( media-libs/libogg )
		matroska? ( media-libs/libmatroska )
		mad? ( media-libs/libmad )
		ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20050226-r1 )
		a52? ( media-libs/a52dec )
		dts? ( media-libs/libdts )
		flac? ( media-libs/flac )
		mpeg? ( >=media-libs/libmpeg2-0.3.2 )
		oggvorbis? ( media-libs/libvorbis )
		theora? ( media-libs/libtheora )
		X? ( virtual/x11 )
		xv? ( virtual/x11 )
		freetype? ( media-libs/freetype
			media-fonts/ttf-bitstream-vera )
		svga? ( media-libs/svgalib )
		ggi? ( media-libs/libggi )
		aalib? ( media-libs/aalib )
		libcaca? ( media-libs/libcaca )
		arts? ( kde-base/arts )
		alsa? ( virtual/alsa )
		wxwindows? ( =x11-libs/wxGTK-2.4* )
		ncurses? ( sys-libs/ncurses )
		xosd? ( x11-libs/xosd )
		lirc? ( app-misc/lirc )
		mozilla? ( www-client/mozilla )
		3dfx? ( !amd64? ( media-libs/glide-v3 ) )
		bidi? ( >=dev-libs/fribidi-0.10.4 )
		gnutls? ( >=net-libs/gnutls-1.0.0 )
		opengl? ( virtual/opengl )
		sys-libs/zlib
		media-libs/libpng
		media-libs/libdvbpsi
		aac?( >=media-libs/faad2-2.0-r2 )
		threads? ( dev-libs/pth )
		sdl? ( >=media-libs/libsdl-1.2.8 )
		ssl? ( net-libs/gnutls )
		portaudio? ( media-libs/portaudio )"

pkg_setup() {
	WX_GTK_VER="2.4"
	if use gtk2; then
		if use unicode; then
			need-wxwidgets unicode || die "You need to install wxGTK with unicode support."
		else
			need-wxwidgets gtk2 || die "You need to install wxGTK with gtk2 support."
		fi
	else
		need-wxwidgets gtk || die "You need to install wxGTK with gtk support."
	fi
}

src_unpack() {
	unpack ${A}

	# We only have glide v3 in portage
	cd ${S}
	sed -i \
		-e "s:/usr/include/glide:/usr/include/glide3:" \
		-e "s:glide2x:glide3:" \
		configure

	# Fix the default font
	sed -i -e "s:/usr/share/fonts/truetype/freefont/FreeSerifBold.ttf:/usr/share/fonts/ttf-bitstream-vera/VeraBd.ttf:" modules/misc/freetype.c

	cd ${S}/modules/video_output
	epatch ${FILESDIR}/glide.patch
	cd ${S}

}

src_compile () {
	# Avoid timestamp skews with autotools
	touch configure.ac
	touch aclocal.m4
	touch configure
	touch config.h.in
	touch $(find . -name Makefile.in)

	# reason why:
	# skins2 interface is horribly broken for some reason.
	# Therefore it's being disabled for the standard wxwindows
	# interface which isn't
	myconf="${myconf} --disable-skins2"

	# reason why:
	# cddax needs all this stuff to work
	if use cdio && use cddb && use cdda ; then
		myconf="${myconf} --enable-cddax"
	else
		myconf="${myconf} --disable-cddax"
	fi

	# reason why:
	# mozilla-config is not in ${PATH}
	# so the configure script won't find it
	# unless we setup the proper variable
	if use mozilla ; then
		myconf="${myconf} --enable-mozilla MOZILLA_CONFIG=/usr/lib/mozilla/mozilla-config"
	else
		myconf="${myconf} --disable-mozilla"
	fi

	econf \
		$(use_enable altivec) \
		$(use_enable unicode utf8) \
		$(use_enable stream sout) \
		$(use_enable httpd) \
		$(use_enable vlm) \
		$(use_enable gnutls) \
		$(use_enable v4l) \
		$(use_enable cdda ) \
		$(use_enable vcd ) \
		$(use_enable dvb) \
		$(use_enable dvb pvr) \
		$(use_enable ogg) \
		$(use_enable matroska mkv) \
		$(use_enable flac) \
		$(use_enable oggvorbis vorbis) \
		$(use_enable theora) \
		$(use_enable X x11) \
		$(use_enable xv xvideo) \
		$(use_enable opengl glx) $(use_enable opengl) \
		$(use_enable freetype) \
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
		$(use_enable wxwindows) \
		$(use_enable ncurses) \
		$(use_enable xosd) \
		$(use_enable lirc) \
		$(use_enable joystick) \
		$(use_enable live livedotcom) $(use_with live livedotcom-tree /usr/lib/live) \
		$(use_enable mad) \
		$(use_enable ffmpeg) \
		$(use_enable aac faad) \
		$(use_enable a52) \
		$(use_enable dts) \
		$(use_enable mpeg libmpeg2) \
		$(use_enable ggi) \
		$(use_enable 3dfx glide) \
		$(use_enable threads pth) \
		$(use_enable sdl) \
		$(use_enable ssl gnutls) \
		$(use_enable portaudio) \
		${myconf} || die "configuration failed"

	if [[ $(gcc-major-version) == 2 ]]; then
		sed -i -e s:"-fomit-frame-pointer":: vlc-config || die "-fomit-frame-pointer patching failed"
	fi

	# reason why:
	# looks for xpidl in /usr/lib/mozilla/xpidl
	# and doesn't find it there because it's
	# in /usr/bin! - ChrisWhite
	if use mozilla; then
		sed -e "s:^XPIDL = .*:XPIDL = /usr/bin/xpidl:" -i mozilla/Makefile \
		|| die "could not fix XPIDL path"
	fi

	MAKEOPTS="${MAKEOPTS} -j1"
	emake || die "make of VLC failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed!"

	dodoc ABOUT-NLS AUTHORS MAINTAINERS INSTALL HACKING THANKS TODO NEWS README

	rm -r ${D}/usr/share/vlc/vlc*.png ${D}/usr/share/vlc/vlc*.xpm ${D}/usr/share/vlc/vlc*.ico \
		${D}/usr/share/vlc/kvlc*.png ${D}/usr/share/vlc/kvlc*.xpm ${D}/usr/share/vlc/qvlc*.png \
		${D}/usr/share/vlc/qvlc*.xpm ${D}/usr/share/vlc/gvlc*.png ${D}/usr/share/vlc/gvlc*.xpm \
		${D}/usr/share/vlc/gvlc*.ico ${D}/usr/share/vlc/gnome-vlc*.png \
		${D}/usr/share/vlc/gnome-vlc*.xpm ${D}/usr/share/vlc/skins2

	for res in 16 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins ${S}/share/vlc${res}x${res}.png vlc.png
	done

	make_desktop_entry vlc "VLC Media Player" vlc "AudioVideo;Player"
}
