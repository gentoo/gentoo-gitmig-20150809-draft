# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.8.1.ebuild,v 1.12 2005/03/23 16:18:35 seemant Exp $

# Missing support for...
#	tarkin - package not in portage yet - experimental
#	tremor - package not in portage yet - experimental

inherit libtool gcc eutils

DESCRIPTION="VLC media player - Video player and streamer"
HOMEPAGE="http://www.videolan.org/vlc/"
SRC_URI="http://download.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="a52 3dfx nls unicode debug altivec httpd vlm gnutls live v4l cdio cddb cdda ogg matroska dvb dvd vcd ffmpeg aac dts flac mpeg oggvorbis theora X opengl freetype svg fbcon svga oss aalib ggi libcaca esd arts alsa wxwindows ncurses xosd lirc joystick mozilla hal stream mad xv bidi"

DEPEND="hal? ( >=sys-apps/hal-0.2.97 )
		cdio? ( >=dev-libs/libcdio-0.70 )
		cddb? ( >=media-libs/libcddb-0.9.4 )
		live? ( media-plugins/live )
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
		freetype? ( media-libs/freetype )
		svga? ( media-libs/svgalib )
		ggi? ( media-libs/libggi )
		aalib? ( media-libs/aalib )
		libcaca? ( media-libs/libcaca )
		arts? ( kde-base/arts )
		alsa? ( virtual/alsa )
		wxwindows? ( >=x11-libs/wxGTK-2.3.0 )
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
		aac?( >=media-libs/faad2-2.0-r2 )"

src_unpack() {
	unpack ${A}

	# We only have glide v3 in portage
	cd ${S}
	sed -i \
		-e "s:/usr/include/glide:/usr/include/glide3:" \
		-e "s:glide2x:glide3:" \
		configure

	# Fix the default font
	sed -i -e "s:/usr/share/fonts/truetype/freefont/FreeSerifBold.ttf:/usr/X11R6/lib/X11/fonts/truetype/timesbd.ttf:" modules/misc/freetype.c

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
	$(use_enable opengl glx) \
	$(use_enable opengl) \
	$(use_enable freetype) \
	$(use_enable bidi fribidi) \
	$(use_enable dvd dvdread) \
	$(use_enable dvd dvdplay) \
	$(use_enable dvd dvdnav) \
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
	$(use_enable live livedotcom) \
	$(use_enable mad) \
	$(use_enable ffmpeg) \
	$(use_enable aac faad) \
	$(use_enable a52) \
	$(use_enable dts) \
	$(use_enable mpeg libmpeg2) \
	$(use_enable ggi) \
	$(use_enable 3dfx glide) \
	${myconf} \
	|| die "configuration failed"

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

	insinto /usr/share/applications
	doins ${FILESDIR}/vlc.desktop
}
