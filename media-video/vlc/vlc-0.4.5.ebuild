# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.4.5.ebuild,v 1.5 2003/09/04 04:52:00 msterret Exp $

IUSE="arts qt ncurses dvd gtk nls 3dfx esd directfb kde X alsa ggi oggvorbis gnome"

S=${WORKDIR}/${P}
DESCRIPTION="VideoLAN Client - DVD/video player"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.videolan.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND="X? ( virtual/x11 )
	qt? ( x11-libs/qt )
	dvd? ( media-libs/libdvdread
		media-libs/libdvdcss )
	>=media-libs/libsdl-1.1.8-r1
	esd? ( >=media-sound/esound-0.2.22 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	gtk? ( =x11-libs/gtk+-1.2* )
	kde? ( kde-base/kdelibs )
	arts? ( kde-base/kdelibs )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	ncurses? ( sys-libs/ncurses )
	oggvorbis? ( media-libs/libvorbis )
	alsa? ( >=media-libs/alsa-lib-0.9_rc2 )
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
		cp configure.in configure.in.orig
		sed "s:-lkfile::" \
			configure.in.orig > configure.in

		cd ${S}/plugins/kde
		cp kde_interface.h kde_interface.h.orig
		sed "s:\(#include <kmainwindow.h>\):\1\n#include <kstatusbar.h>:" \
			kde_interface.h.orig > kde_interface.h

		cp kde_preferences.cpp kde_preferences.cpp.orig
		sed 's:\("vlc preferences", true, false, \)\("Save\):\1(KGuiItem)\2:' \
			kde_preferences.cpp.orig > kde_preferences.cpp
	fi
	)
}

src_compile(){

	use X \
		&& myconf="${myconf} --enable-x11 --enable-xvideo" \
		|| myconf="${myconf} --disable-x11 --disable-xvideo"

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

	use directfb \
		&& myconf="${myconf} --enable-fb" \
		|| myconf="${myconf} --disable-fb"

	use oggvorbis \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis"

	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"

	# vlc uses its own ultraoptimizaed CXXFLAGS
	# and forcing custom ones generally fails building
	export CXXFLAGS=""
	export CFLAGS=""

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

	dodoc AUTHORS COPYING ChangeLog FAQ INSTALL* README* MODULES TODO

}
