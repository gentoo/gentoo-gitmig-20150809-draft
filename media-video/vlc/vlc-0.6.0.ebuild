# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.6.0.ebuild,v 1.1 2003/06/26 21:29:50 raker Exp $

# NOTE: Some ideas for version specifics, etc...  have been referenced 
# from the videolan.org ebuild.  Thanks guys!

IUSE="arts qt ncurses dvd gtk nls 3dfx matrox svga fbcon esd kde X alsa ggi oggvorbis gnome xv oss sdl aalib slp truetype v4l xvid lirc wxwindows imlib"

S=${WORKDIR}/${P}
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
	dvd? ( >=media-libs/libdvdread-0.9.3
		>=media-libs/libdvdcss-1.2.6
		>=media-libs/libdvdplay-1.0.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	gtk? ( =x11-libs/gtk+-1.2* )
	imlib? ( >=media-libs/imlib2-1.0.6 )
	kde? ( kde-base/kdelibs )
	lirc? ( app-misc/lirc )
	mad? ( >=media-sound/mad-0.14.2b )
	ncurses? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	oggvorbis? ( >=media-libs/libvorbis-1.0 
	             >=media-libs/libogg-1.0 )
	qt? ( x11-libs/qt )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	slp? ( >=net-libs/openslp-1.0.10 )
	truetype? ( >=media-libs/freetype-2.1.4 )
	wxwindows? ( >=x11-libs/wxGTK-2.4.0 )
	xvid? ( >=media-libs/xvid-0.9.1 )
	>=media-libs/a52dec-0.7.4
	>=media-libs/faad2-1.1
	>=media-libs/flac-1.1.0
	>=media-libs/libdv-0.98
        >=media-libs/libdvbpsi-0.1.2
	>media-video/ffmpeg-0.4.6
	>media-libs/libmpeg2-0.3.1"

# vlc requires cvs-pulled builds of ffmpeg and libmpeg2
# I have added these builds to portage as...
# ffmpeg-0.4.7_pre20030624 and libmpeg2-0.3.2_pre20030625
#   -raker@gentoo.org
#
# Missing support for...
#	tarkin
#	theora
#	tremor

# get kde and arts paths
if [ -n "`use kde`" -o -n "`use arts`" ]; then
    inherit kde-functions
    set-kdedir 3
    # $KDEDIR is now set to arts/kdelibs location
fi

src_unpack() {
	
	unpack ${A}
	cd ${S}

	# if qt3 is installed, patch vlc to work with it instead of qt2
	( use qt || use kde ) && ( \
	if [ ${QTDIR} = "/usr/qt/3" ]
	then
		cp configure.ac configure.ac.orig
		sed "s:-lkfile::" \
			configure.ac.orig > configure.ac

		cd ${S}/modules/gui/kde
		cp interface.h interface.h.orig
		sed "s:\(#include <kmainwindow.h>\):\1\n#include <kstatusbar.h>:" \
			interface.h.orig > interface.h

		cp preferences.cpp preferences.cpp.orig
		sed 's:\("vlc preferences", true, false, \)\("Save\):\1(KGuiItem)\2:' \
			preferences.cpp.orig > preferences.cpp
	fi
	)
}

src_compile(){

	cd ${S}
	myconf=""

	use X || myconf="${myconf} --disable-x11"

	use xv || myconf="${myconf} --disable-xvideo"

	use ggi && myconf="${myconf} --enable-ggi"

        use 3dfx && myconf="${myconf} --enable-glide"

        use matrox && myconf="${myconf} --enable-mga"

        use svga && myconf="${myconf} --enable-svgalib"

	use sdl || myconf="${myconf} --disable-sdl"

        use fbcon || myconf="${myconf} --disable-fb"

        use aalib && myconf="${myconf} --enable-aa"

	use dvd \
		&& myconf="${myconf} --enable-dvdread" \
		|| myconf="${myconf} \
			--disable-dvd \
			--disable-dvdread \
			--disable-dvdplay \
			--disable-vcd"

	use alsa && myconf="${myconf} --enable-alsa"

        use oss || myconf="${myconf} --disable-oss"

	use esd && myconf="${myconf} --enable-esd"

	use arts && myconf="${myconf} --enable-arts"

	use nls || myconf="${myconf} --disable-nls"

	use gtk \
		&& myconf="${myconf} --disable-gtk2" \
		|| myconf="${myconf} --disable-gtk --disable-gtk2"

	use gnome && myconf="${myconf} --enable-gnome --disable-gnome2"

	use kde && myconf="${myconf} --enable-kde"

	use qt && myconf="${myconf} --enable-qt"

	use ncurses && myconf="${myconf} --enable-ncurses"

	use oggvorbis || myconf="${myconf} --disable-vorbis --disable-ogg"

	use lirc && myconf="${myconf} --enable-lirc"

	use slp || myconf="${myconf} --disable-slp"

	use mad && myconf="${myconf} --enable-mad"

	use v4l && myconf="${myconf} --enable-v4l"

	(use imlib && use wxwindows) && myconf="${myconf} --enable-skins"

	use xvid && myconf="${myconf} --enable-xvid"

	# vlc uses its own ultraoptimizaed CXXFLAGS
	# and forcing custom ones generally fails building
	export CXXFLAGS=""
	export CFLAGS=""
	export WANT_AUTOCONF_2_5=1
	export WANT_AUTOMAKE_1_6=1

	myconf="${myconf} \
		--enable-release \
		--enable-faad \
		--enable-a52 \
		--enable-dvbpsi"

	ewarn ${myconf}
	econf ${myconf} || die "configure of VLC failed"

	make || die "make of VLC failed"
}

src_install() {
	
	einstall || die "make install failed"

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING INSTALL* \
	MAINTAINERS NEWS README* MODULES THANKS

}
