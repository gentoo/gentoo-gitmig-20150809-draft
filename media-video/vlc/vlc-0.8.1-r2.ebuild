# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.8.1-r2.ebuild,v 1.7 2005/07/12 16:49:53 flameeyes Exp $

# Missing support for...
#	tarkin - package not in portage yet - experimental
#	tremor - package not in portage yet - experimental

inherit libtool toolchain-funcs eutils wxwidgets

PATCHLEVEL="1"
DESCRIPTION="VLC media player - Video player and streamer"
HOMEPAGE="http://www.videolan.org/vlc/"
SRC_URI="http://download.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2
	http://digilander.libero.it/dgp85/gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="a52 3dfx nls unicode debug altivec httpd vlm gnutls live v4l cdio cddb cdda ogg matroska dvb dvd vcd ffmpeg aac dts flac mpeg vorbis theora X opengl freetype svg fbcon svga oss aalib ggi libcaca esd arts alsa wxwindows ncurses xosd lirc joystick nsplugin hal stream mad xv bidi gtk2 sdl ssl"

RDEPEND="hal? ( =sys-apps/hal-0.4* )
		cdio? ( >=dev-libs/libcdio-0.70 )
		cddb? ( >=media-libs/libcddb-0.9.4 )
		live? ( >=media-plugins/live-2005.01.29 )
		dvd? (  media-libs/libdvdread
				media-libs/libdvdcss
				>=media-libs/libdvdnav-0.1.9
				media-libs/libdvdplay )
		esd? ( media-sound/esound )
		ogg? ( media-libs/libogg )
		matroska? ( >=media-libs/libmatroska-0.7.3-r1 )
		mad? ( media-libs/libmad )
		ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20050226-r1 )
		a52? ( media-libs/a52dec )
		dts? ( media-libs/libdts )
		flac? ( media-libs/flac )
		mpeg? ( >=media-libs/libmpeg2-0.3.2 )
		vorbis? ( media-libs/libvorbis )
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
		nsplugin? ( www-client/mozilla )
		3dfx? ( media-libs/glide-v3 )
		bidi? ( >=dev-libs/fribidi-0.10.4 )
		gnutls? ( >=net-libs/gnutls-1.0.0 )
		opengl? ( virtual/opengl )
		sys-libs/zlib
		media-libs/libpng
		media-libs/libdvbpsi
		aac? ( >=media-libs/faad2-2.0-r2 )
		sdl? ( >=media-libs/libsdl-1.2.8 )
		ssl? ( net-libs/gnutls )"
#		threads? ( dev-libs/pth )
#		portaudio? ( >=media-libs/portaudio-0.19 )

DEPEND="${RDEPEND}
	dev-util/cvs
	>=sys-devel/gettext-0.11.5
	=sys-devel/automake-1.6*
	sys-devel/autoconf
	dev-util/pkgconfig"


pkg_setup() {
	if use wxwindows; then
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
	fi
}

src_unpack() {
	unpack ${A}

	# We only have glide v3 in portage
	cd ${S}

	EPATCH_EXCLUDE="01_all_nohal.patch"
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/${PV}"

	./bootstrap

	sed -i -e \
		"s:/usr/include/glide:/usr/include/glide3:;s:glide2x:glide3:" \
		configure || die "sed glibc failed."

	# Fix the default font
	sed -i -e "s:/usr/share/fonts/truetype/freefont/FreeSerifBold.ttf:/usr/share/fonts/ttf-bitstream-vera/VeraBd.ttf:" modules/misc/freetype.c

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
	if use nsplugin ; then
		myconf="${myconf} --enable-mozilla MOZILLA_CONFIG=/usr/lib/mozilla/mozilla-config"
	else
		myconf="${myconf} --disable-mozilla"
	fi

	# Portaudio support needs at least v19
	# pth (threads) support is quite unstable with latest ffmpeg/libmatroska.
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
		$(use_enable vorbis) \
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
		$(use_enable sdl) \
		$(use_enable ssl gnutls) \
		--disable-pth \
		--disable-portaudio \
		${myconf} || die "configuration failed"

	if [[ $(gcc-major-version) == 2 ]]; then
		sed -i -e s:"-fomit-frame-pointer":: vlc-config || die "-fomit-frame-pointer patching failed"
	fi

	# reason why:
	# looks for xpidl in /usr/lib/mozilla/xpidl
	# and doesn't find it there because it's
	# in /usr/bin! - ChrisWhite
	if use nsplugin; then
		sed -e "s:^XPIDL = .*:XPIDL = /usr/bin/xpidl:" -i mozilla/Makefile \
		|| die "could not fix XPIDL path"
	fi

	MAKEOPTS="${MAKEOPTS} -j1"
	emake || die "make of VLC failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed!"

	dodoc ABOUT-NLS AUTHORS MAINTAINERS HACKING THANKS TODO NEWS README \
		doc/fortunes.txt doc/intf-cdda.txt doc/intf-vcd.txt

	rm -r ${D}/usr/share/vlc/vlc*.png ${D}/usr/share/vlc/vlc*.xpm ${D}/usr/share/vlc/vlc*.ico \
		${D}/usr/share/vlc/kvlc*.png ${D}/usr/share/vlc/kvlc*.xpm ${D}/usr/share/vlc/qvlc*.png \
		${D}/usr/share/vlc/qvlc*.xpm ${D}/usr/share/vlc/gvlc*.png ${D}/usr/share/vlc/gvlc*.xpm \
		${D}/usr/share/vlc/gvlc*.ico ${D}/usr/share/vlc/gnome-vlc*.png \
		${D}/usr/share/vlc/gnome-vlc*.xpm ${D}/usr/share/vlc/skins2 \
		${D}/usr/share/doc/vlc

	for res in 16 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins ${S}/share/vlc${res}x${res}.png vlc.png
	done

	make_desktop_entry vlc "VLC Media Player" vlc "AudioVideo;Player"
}
