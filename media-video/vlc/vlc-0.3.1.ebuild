# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Nathaniel Hirsch <nh2@njit.edu> 
# Author: Achim Gottinger <achim@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.3.1.ebuild,v 1.1 2002/05/07 16:06:54 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DVD / video player"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.videolan.org"

DEPEND=">=media-libs/libsdl-1.1.8-r1
	>=media-libs/libdvdcss-1.1.1
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	esd? ( >=media-sound/esound-0.2.22 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	qt? ( =x11-libs/qt-2.3* )
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
	X? ( virtual/x11 )"
	#alsa? ( >=media-libs/alsa-lib-0.5.10 )
	#kde? ( >=kde-base/kdelibs-2.1.1 )

src_compile() {
	local myc

	use fbdev && myc="$myc --enable-fb"  || myc="$myc --disable-fb"
	use mmx && myc="$myc --enable-mmx" || myc="$myc --disable-mmx"
	use esd && myc="$myc --enable-esd" || myc="$myc --disable-esd"
	use ggi && myc="$myc --with-ggi" || myc="$myc --without-ggi"	

	if [ "`use qt`" ] ; then
		export QTDIR=/usr/qt/2
		myc="$myc --enable-qt"
	fi

	#use kde && myc="$myc --enable-kde" || myc="$myc --disable-kde"
	use gnome && myc="$myc --enable-gnome" || myc="$myc --disable-gnome"
	use gtk && myc="$myc --enable-gtk" || myc="$myc --disable-gtk"
	use X && myc="$myc --enable-xvideo" || myc="$myc --disable-x11"

#    Currently alsa support in vlc requires Alsa 0.90 (which is unstable).
#    Until some release of alsa is released which works with vlc don't use it.
#    if [ "`use alsa`" ]
#    then
#      myconf="$myconf --enable-alsa"
#    fi

	# vlc uses its own ultraoptimizaed CXXFLAGS, and forcing custom ones generally fails building
	export CXXFLAGS=""
	export CFLAGS=""
    

	# Why are we requiring SDL here ? -- karltk
	./configure \
		--prefix=/usr \
		$myconf \
		--with-sdl \
		--disable-alsa \
		--enable-release || die
	make || die
}

src_install() {
	dodir /usr/{bin,lib}
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING FAQ INSTALL README TODO
}

