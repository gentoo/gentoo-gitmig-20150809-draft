# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Nathaniel Hirsch <nh2@njit.edu> Achim Gottinge <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.4.0.ebuild,v 1.1 2002/05/24 09:43:37 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="VideoLAN Client - DVD/video player"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.videolan.org"

DEPEND="X? ( virtual/x11 )
	qt? ( =x11-libs/qt-2.3* )
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
	oggvorbis? ( >=media-libs/libvorbis )
	alsa? ( >=media-libs/alsa-lib-0.9_rc1 )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile(){

	use X \
		&& myconf="${myconf} --enable-x11 --enable-xvideo" \
		|| myconf="${myconf} --disable-x11 --disable-x11"

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
	
	./configure \
		--prefix=/usr \
		--with-sdl \
		--disable-alsa \
		--disable-a52 \
		--enable-release \
		${myconf} || die

	make || die
}

src_install() {

	dodir /usr/{bin,lib}
	make DESTDIR=${D} install || die

}

