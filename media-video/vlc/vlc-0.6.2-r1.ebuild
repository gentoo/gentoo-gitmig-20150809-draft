# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.6.2-r1.ebuild,v 1.5 2004/01/07 09:35:59 aliz Exp $

inherit libtool

# Missing support for...
#	tarkin - package not in portage yet - experimental
#	theora - package not in portage yet - experimental
#	tremor - package not in portage yet - experimental

inherit gcc

IUSE="arts qt ncurses dvd gtk nls 3dfx svga fbcon esd kde X alsa ggi
	oggvorbis gnome xv oss sdl aalib slp truetype v4l xvid lirc
	wxwindows imlib mozilla dvb debug faad xosd matroska altivec"

PFFM=ffmpeg-20030813
PMPG=mpeg2dec-20030612

S=${WORKDIR}/${P}
SFFM=${WORKDIR}/${PFFM}
SMPG=${WORKDIR}/${PMPG}
DESCRIPTION="VideoLAN Client - DVD/video player and more"
HOMEPAGE="http://www.videolan.org/vlc"
SRC_URI="http://www.videolan.org/pub/${PN}/${PV}/${P}.tar.bz2
	http://www.videolan.org/pub/${PN}/${PV}/contrib/${PMPG}.tar.bz2
	http://www.videolan.org/pub/${PN}/${PV}/contrib/${PFFM}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~mips ~amd64 ~ia64"

DEPEND="X? ( virtual/x11 )
	aalib? ( >=media-libs/aalib-1.4_rc4-r2 )
	alsa? ( >=media-libs/alsa-lib-0.9_rc2 )
	arts? ( kde-base/kdelibs )
	dvb? ( media-libs/libdvb
		media-tv/linuxtv-dvb )
	dvd? ( >=media-libs/libdvdread-0.9.3
		>=media-libs/libdvdcss-1.2.8
		>=media-libs/libdvdplay-1.0.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	faad? ( >=media-libs/faad2-1.1 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	gtk? ( =x11-libs/gtk+-1.2* )
	imlib? ( >=media-libs/imlib2-1.0.6 )
	kde? ( kde-base/kdelibs )
	lirc? ( app-misc/lirc )
	mad? ( >=media-sound/mad-0.14.2b )
	matroska? ( >=media-libs/libmatroska-0.4.4 )
	mozilla? ( >=net-www/mozilla-1.4 )
	ncurses? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	oggvorbis? ( >=media-libs/libvorbis-1.0 >=media-libs/libogg-1.0 )
	qt? ( x11-libs/qt )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	slp? ( >=net-libs/openslp-1.0.10 )
	truetype? ( >=media-libs/freetype-2.1.4 )
	wxwindows? ( >=x11-libs/wxGTK-2.4.1 )
	xosd? ( >=x11-libs/xosd-2.0 )
	xvid? ( >=media-libs/xvid-0.9.1 )
	3dfx? ( media-libs/glide-v3 )
	>=media-libs/a52dec-0.7.4
	flac? ( >=media-libs/flac-1.1.0 )
	>=media-libs/libdv-0.98
	>=media-libs/libdvbpsi-0.1.3"


# mplayer is a required dependancy until the libpostproc code becomes
# a separate packages or until ffmpeg gets support for installing
# the library.


# get kde and arts paths
if [ -n "`use kde`" -o -n "`use arts`" ]; then
	inherit kde-functions
	set-kdedir 3
	# $KDEDIR is now set to arts/kdelibs location
fi

src_unpack() {
	unpack ${A}

	# Mozilla plugin related fix
	epatch ${FILESDIR}/${PV}-mozilla-fix.patch

	cd ${S}

	# if qt3 is installed, patch vlc to work with it instead of qt2
	if use qt || use kde
	then
		if [ ${QTDIR} = "/usr/qt/3" ]
		then
			sed -i -e "s:-lkfile::" configure

			cd ${S}/modules/gui/kde
			sed -i \
				"s:\(#include <kmainwindow.h>\):\1\n#include <kstatusbar.h>:" \
				interface.h

			sed -i \
				's:\("vlc preferences", true, false, \)\("Save\):\1(KGuiItem)\2:' \
				preferences.cpp
		fi
	fi

	# We only have glide v3 in portage
	cd ${S}
	sed -i \
		-e "s:/usr/include/glide:/usr/include/glide3:" \
		-e "s:glide2x:glide3:" \
		configure

	cd ${S}/modules/video_output
	epatch ${FILESDIR}/glide.patch
	cd ${S}

	# Patch libmpeg2
	cd ${SMPG}
	epatch ${FILESDIR}/${PMPG}-configure.in-fpic.patch

	cd ${S}
	touch configure.ac
	touch aclocal.m4
	touch configure
	touch config.h.in
	touch `find . -name Makefile.in`
}

src_compile() {
	# first build the deps
	# LibMPEG2:
	cd ${SMPG}
	autoconf
	econf \
		--disable-sdl \
		--without-x \
		`use_enable mmx` || die "libmpeg2 failed to configure"

	emake OPT_CFLAGS="${CFLAGS}" || make OPT_CFLAGS="${CFLAGS}" || die

	# ffMPEG
	cd ${SFFM}
	./configure \
		--enable-mp3lame \
		--disable-vorbis || die "ffmpeg failed to configure"

	cd libavcodec
	make || die "ffmpeg->libavcodec failed to compile"
	cd libpostproc
	make || die "ffmpeg->libpostproc failed to compile"

	cd ${S}
	local myconf
	myconf="--disable-mga --enable-flac --with-gnu-ld \
			--enable-a52 --enable-dvbpsi"

	#--enable-pth            GNU Pth support (default disabled)
	#--enable-st             State Threads (default disabled)
	#--enable-gprof          gprof profiling (default disabled)
	#--enable-cprof          cprof profiling (default disabled)
	#--enable-mostly-builtin most modules will be built-in (default disabled)
	#--disable-optimizations disable compiler optimizations (default enabled)
	#--enable-testsuite      build test modules (default disabled)
	#--disable-plugins       make all plugins built-in (default plugins enabled)

	use debug && myconf="${myconf} --enable-debug" \
		|| myconf="${myconf} --enable-release"

	(use imlib && use wxwindows) && myconf="${myconf} --enable-skins"

	use mozilla \
		&& myconf="${myconf} --enable-mozilla \
		MOZILLA_CONFIG=/usr/lib/mozilla/mozilla-config \
		XPIDL=/usr/bin/xpidl"

	export CXXFLAGS=""
	export CFLAGS=""
	export WANT_AUTOCONF_2_5=1
	export WANT_AUTOMAKE_1_6=1

	myconf="${myconf} --enable-ffmpeg \
		--with-ffmpeg-tree=${SFFM} \
		--with-ffmpeg-mp3lame \
		--enable-libmpeg2 \
		--with-libmpeg2-tree=${SMPG}"

	econf \
		`use_enable nls` \
		`use_enable slp` \
		`use_enable xosd` \
		`use_enable ncurses` \
		`use_enable alsa` \
		`use_enable esd` \
		`use_enable oss` \
		`use_enable ggi` \
		`use_enable sdl` \
		`use_enable mad` \
		`use_enable faad` \
		`use_enable xvid` \
		`use_enable v4l` \
		`use_enable dvd` \
		`use_enable dvd vcd` `use_enable dvdread` `use_enable dvd dvdplay` \
		`use_enable dvb satellite` `use_enable dvb pvr` \
		`use_enable joystick` `use_enable lirc` \
		`use_enable qt` `use_enable kde` `use_enable arts` \
		`use_enable gtk` `use_enable gnome` \
		`use_enable oggvorbis ogg` `use_enable oggvorbis vorbis` \
		`use_enable matroska mkv` \
		`use_enable truetype freetype` \
		`use_enable svga svgalib` \
		`use_enable fbcon fb` \
		`use_enable aalib aa` \
		`use_enable xv xvideo` \
		`use_enable X x11` \
		`use_enable 3dfx glide` \
		`use_enable altivec` \
		${myconf} || die "configure failed"

	if [ `gcc-major-version` -eq 2 ]; then
		sed -i s:"-fomit-frame-pointer":: vlc-config
	fi

	MAKEOPTS="${MAKEOPTS} -j1"
	make || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING INSTALL* \
	MAINTAINERS NEWS README* THANKS doc/ChangeLog-*
}
