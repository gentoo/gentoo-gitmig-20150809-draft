# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-0.9-r1.ebuild,v 1.4 2004/01/26 00:49:35 vapier Exp $

inherit eutils

DESCRIPTION="Great Video editing/encoding tool"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="debug nls oggvorbis arts truetype alsa"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	>=media-sound/mad-0.14.2b*
	>=media-libs/a52dec-0.7.4
	>=media-sound/lame-3.93*
	>=media-video/mjpegtools-1.6*
	>=dev-libs/libxml2-2.5.6
	>=media-libs/xvid-0.9*
	=media-libs/divx4linux-20020418*
	nls? ( >=sys-devel/gettext-0.11.2 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	arts? ( >=kde-base/arts-1.1.1 )
	truetype? ( >=media-libs/freetype-2.1.2 )
	alsa? ( >=media-libs/alsa-lib-0.9.1 )"

src_compile() {

	cd ${S}

	#Fixing libxml2 issue
	if has_version '>=dev-libs/libxml2-2.5.7'
	then
		einfo "libxml2 >= 2.5.7 found"
		epatch ${FILESDIR}/avidemux-0.9-libxml2.5.7.patch
	else
		einfo "Old libxml2 found"
	fi

	# Fixes a possible automake error due to clock skew
	touch -r *
	export WANT_AUTOCONF=2.5
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
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog History INSTALL README TODO
}
