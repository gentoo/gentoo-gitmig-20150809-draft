# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.0.14.ebuild,v 1.1 2003/08/17 11:55:15 mholzer Exp $

IUSE="debug nls oggvorbis arts truetype alsa"

inherit eutils

MY_P=${P}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Great Video editing/encoding tool. New, gtk2 version"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86"

DEPEND="virtual/x11
   media-sound/mad
   >=media-libs/a52dec-0.7.4
   >=media-sound/lame-3.93
   >=media-video/mjpegtools-1.6
   >=media-libs/xvid-0.9
   >=dev-libs/libxml2-2.5.7
   >=x11-libs/gtk+-2.2.1
   >=media-libs/divx4linux-20020418-r1
   nls? ( >=sys-devel/gettext-0.11.2 )
   oggvorbis? ( >=media-libs/libogg-1.0 
                >=media-libs/libvorbis-1.0 )
   arts? ( >=kde-base/arts-1.1.1 )
   truetype? ( >=media-libs/freetype-2.1.2 )
   alsa? ( >=media-libs/alsa-lib-0.9.1 )"
# media-sound/toolame is supported as well

pkg_setup() {
	ewarn ""
	ewarn "You MAY notice DivX support is disabled."
	ewarn "This will be fixed in the next upstream release"
	ewarn ""
}

src_compile() {
	# Fixes a possible automake error due to clock skew
	touch -r *

	export WANT_AUTOCONF_2_5=1
	autoconf

	local myconf
	myconf="--with-gnu-ld --disable-warnings"

	# --enable-profile        creates profiling infos default=no
  	# --enable-pch            enables precompiled header support 
	#                         (currently only KCC) default=no
	# --enable-final          build size optimized apps 
	#                         (experimental - needs lots of memory)
	# --disable-closure       don't delay template instantiation

	use debug && myconf="${myconf} --enable-debug=full"
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "configure failed"

	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog History README TODO
}
