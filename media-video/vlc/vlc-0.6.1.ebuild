# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.6.1.ebuild,v 1.4 2004/01/25 04:38:42 vapier Exp $

# Missing support for...
#	tarkin - package not in portage yet - experimental
#	theora - package not in portage yet - experimental
#	tremor - package not in portage yet - experimental

inherit eutils

IUSE="arts qt ncurses dvd gtk nls 3dfx svga fbcon esd kde X alsa ggi
	oggvorbis gnome xv oss sdl aalib slp truetype v4l xvid lirc
	wxwindows imlib mozilla dvb debug faad xosd matroska"

DESCRIPTION="VideoLAN Client - DVD/video player and more"
SRC_URI="http://www.videolan.org/pub/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.videolan.org/vlc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

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
	>=media-libs/a52dec-0.7.4
	>=media-libs/flac-1.1.0
	>=media-libs/libdv-0.98
	>=media-libs/libdvbpsi-0.1.3
	>media-video/ffmpeg-0.4.6
	>media-libs/libmpeg2-0.3.1
	>=media-video/mplayer-0.90"

# mplayer is a required dependancy until the libpostproc code becomes
# a separate packages or until ffmpeg get support for installing
# the library.

# get kde and arts paths
if [ -n "`use kde`" -o -n "`use arts`" ]; then
	inherit kde-functions
	set-kdedir 3
	# $KDEDIR is now set to arts/kdelibs location
fi

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/buildorder.patch

	# if qt3 is installed, patch vlc to work with it instead of qt2
	( use qt || use kde ) && ( \
	if [ ${QTDIR} = "/usr/qt/3" ]
	then
		sed -i -e "s:-lkfile::" configure

		cd ${S}/modules/gui/kde
		sed -i -e "s:\(#include <kmainwindow.h>\):\1\n#include <kstatusbar.h>:" interface.h

		sed -i -e 's:\("vlc preferences", true, false, \)\("Save\):\1(KGuiItem)\2:' preferences.cpp
	fi
	)

	# Change the location where glide headers are installed
	cd ${S}
	sed -i -e "s:/usr/include/glide:/usr/include/glide3:" configure
}

src_compile(){
	local myconf
	myconf="--disable-mga --enable-flac --with-gnu-ld"

	#--enable-pth            GNU Pth support (default disabled)
	#--enable-st             State Threads (default disabled)
	#--enable-gprof          gprof profiling (default disabled)
	#--enable-cprof          cprof profiling (default disabled)
	#--enable-mostly-builtin most modules will be built-in (default disabled)
	#--disable-optimizations disable compiler optimizations (default enabled)
	#--disable-altivec       disable AltiVec optimizations (default enabled on PPC)
	#--enable-testsuite      build test modules (default disabled)
	#--disable-plugins       make all plugins built-in (default plugins enabled)

	use nls || myconf="${myconf} --disable-nls"

	use debug && myconf="${myconf} --enable-debug" \
		|| myconf="${myconf} --enable-release"

	use dvd \
		&& myconf="${myconf} --enable-dvdread" \
		|| myconf="${myconf} \
			--disable-dvd \
			--disable-dvdread \
			--disable-dvdplay \
			--disable-vcd"

	use v4l && myconf="${myconf} --enable-v4l"

	use dvb && myconf="${myconf} --enable-satellite --enable-pvr"

	use oggvorbis || myconf="${myconf} --disable-vorbis --disable-ogg"

	use matroska || myconf="${myconf} --disable-mkv"

	use mad && myconf="${myconf} --enable-mad"

	use faad && myconf="${myconf} --enable-faad"

	use xvid && myconf="${myconf} --enable-xvid"

	use X || myconf="${myconf} --disable-x11"

	use xv || myconf="${myconf} --disable-xvideo"

	use sdl || myconf="${myconf} --disable-sdl"

	use truetype && myconf="${myconf} --enable-freetype"

	use fbcon || myconf="${myconf} --disable-fb"

	use svga && myconf="${myconf} --enable-svgalib"

	use ggi && myconf="${myconf} --enable-ggi"

	use 3dfx && myconf="${myconf} --enable-glide"

	use aalib && myconf="${myconf} --enable-aa"

	use oss || myconf="${myconf} --disable-oss"

	use esd && myconf="${myconf} --enable-esd"

	use arts && myconf="${myconf} --enable-arts"

	use alsa && myconf="${myconf} --enable-alsa"

	(use imlib && use wxwindows) && myconf="${myconf} --enable-skins"

	use gtk || myconf="${myconf} --disable-gtk"

	use gnome && myconf="${myconf} --enable-gnome"

	use qt && myconf="${myconf} --enable-qt"

	use kde && myconf="${myconf} --enable-kde"

	use ncurses && myconf="${myconf} --enable-ncurses"

	use xosd && myconf="${myconf} --enable-xosd"

	use slp || myconf="${myconf} --disable-slp"

	use lirc && myconf="${myconf} --enable-lirc"

	use joystick && myconf="${myconf} --enable-joystick"

	use mozilla && \
		myconf="${myconf} --enable-mozilla \
		MOZILLA_CONFIG=/usr/lib/mozilla/mozilla-config \
		XPIDL=/usr/bin/xpidl"

	export CXXFLAGS=""
	export CFLAGS=""
	export WANT_AUTOCONF_2_5=1
	export WANT_AUTOMAKE_1_6=1

	# The buildorder.patch changes Makefile.am, so we need to
	# run automake so the change is propogated
	automake

	econf ${myconf} || die "configure of VLC failed"

	MAKEOPTS="${MAKEOPTS} -j1"
	emake || die "make of VLC failed"
}

src_install() {
	einstall || die "make install failed"

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING INSTALL* \
	MAINTAINERS NEWS README* THANKS doc/ChangeLog-*
}
