# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.5.2-r1.ebuild,v 1.4 2003/09/04 04:52:00 msterret Exp $

IUSE="arts qt ncurses dvd gtk nls 3dfx esd kde X alsa ggi oggvorbis gnome xv oss sdl fbcon aalib"

S=${WORKDIR}/${P}
DESCRIPTION="VideoLAN Client - DVD/video player"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.videolan.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="X? ( virtual/x11 )
	qt? ( x11-libs/qt )
	dvd? ( media-libs/libdvdread
		media-libs/libdvdcss )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	esd? ( >=media-sound/esound-0.2.22 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	gtk? ( =x11-libs/gtk+-1.2* )
	kde? ( kde-base/kdelibs )
	arts? ( kde-base/kdelibs )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	ncurses? ( sys-libs/ncurses )
	oggvorbis? ( media-libs/libvorbis )
	alsa? ( >=media-libs/alsa-lib-0.9_rc2 )
	aalib? ( >=media-libs/aalib-1.4_rc4-r2 )
	>=media-sound/mad-0.14.2b
	>=media-libs/a52dec-0.7.4
	>=media-libs/libdvbpsi-0.1.1"

RDEPEND="nls? ( sys-devel/gettext )"

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
		# adding configure.ac.in
		cp configure.ac.in configure.ac.in.orig
		sed "s:-lkfile::" \
			configure.ac.in.orig > configure.ac.in

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

	use X \
		&& myconf="${myconf} --enable-x11" \
		|| myconf="${myconf} --disable-x11"

	use xv\
		&& myconf="${myconf} --enable-xvideo" \
		|| myconf="${myconf} --diable-xvideo"

	use qt \
		&& myconf="${myconf} --enable-qt" \
		|| myconf="${myconf} --disable-qt"

	use dvd \
		&& myconf="${myconf} \
			--enable-dvd \
			--enable-dvdread \
			--enable-vcd" \
		|| myconf="${myconf} --disable-dvd --disable-dvdread --disable-vcd"

	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd"

	use ggi \
		&& myconf="${myconf} --enable-ggi" \
		|| myconf="${myconf} --disable-ggi"

	use gtk \
		&& myconf="${myconf} --enable-gtk" \
		|| myconf="${myconf} --disable-gtk"

	use kde \
		&& myconf="${myconf} --enable-kde" \
		|| myconf="${myconf} --disable-kde"

	use nls \
		|| myconf="${myconf} --disable-nls"

	use 3dfx \
		&& myconf="${myconf} --enable-glide" \
		|| myconf="${myconf} --disable-glide"

	use arts \
		&& myconf="${myconf} --enable-arts" \
		|| myconf="${myconf} --disable-arts"

	use gnome \
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"

	use ncurses \
		&& myconf="${myconf} --enable-ncurses" \
		|| myconf="${myconf} --disable-ncurses"

	use oggvorbis \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis --disable-ogg"

	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"

	use oss \
		&& myconf="${myconf} --enable-oss" \
		|| myconf="${myconf} --disable-oss"

	use sdl \
		&& myconf="${myconf} --enable-sdl" \
		|| myconf="${myconf} --disable-sdl"

	use fbcon \
		&& myconf="${myconf} --enable-fb" \
		|| myconf="${myconf} --disable-fb"

	use aalib \
		&& myconf="${myconf} --enable-aa" \
		|| myconf="${myconf} --disable-aa"

	# vlc uses its own ultraoptimizaed CXXFLAGS
	# and forcing custom ones generally fails building
	export CXXFLAGS=""
	export CFLAGS=""
	export WANT_AUTOCONF_2_5=1
	export WANT_AUTOMAKE_1_6=1


	autoconf || die

	econf \
		--with-sdl \
		--enable-release \
		--enable-mad \
		--enable-a52 \
		--enable-dvbpsi \
		${myconf} || die "configure failed"

	emake || die "parallel make failed"
}

src_install() {

	dodir /usr/{bin,lib}

	einstall || die "make install failed"

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING INSTALL* \
	MAINTAINERS NEWS README* MODULES THANKS

}
