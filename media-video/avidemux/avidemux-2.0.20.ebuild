# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.0.20.ebuild,v 1.4 2004/02/01 01:15:55 mholzer Exp $

inherit eutils flag-o-matic

MY_P=${P}
DESCRIPTION="Great Video editing/encoding tool"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc"
IUSE="debug nls oggvorbis arts truetype alsa"

RDEPEND="virtual/x11
	media-sound/mad
	>=media-libs/a52dec-0.7.4
	>=media-sound/lame-3.93
	>=media-video/mjpegtools-1.6
	>=media-libs/xvid-0.9
	>=dev-libs/libxml2-2.5.7
	>=x11-libs/gtk+-2.2.4-r1
	x86? ( >=media-libs/divx4linux-20030428 )
	x86? ( dev-lang/nasm )
	nls? ( >=sys-devel/gettext-0.11.2 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	arts? ( >=kde-base/arts-1.1.1 )
	truetype? ( >=media-libs/freetype-2.1.2 )
	alsa? ( >=media-libs/alsa-lib-0.9.1 )"
# media-sound/toolame is supported as well

DEPEND="$RDEPEND >=sys-devel/autoconf-2.58"

S=${WORKDIR}/${MY_P}

filter-flags "-fno-default-inline"

src_compile() {
	# Fixes a possible automake error due to clock skew
	touch -r *

	export WANT_AUTOCONF=2.5
	autoconf

	# invalid cast
	use ppc \
		&& sed -i -e '188s/const//g' avidemux/ADM_video/ADM_vidFont.cpp

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

	filter-flags -funroll-loops
	filter-flags -maltivec -mabi=altivec

	econf ${myconf} || die "configure failed"

	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog History README TODO
}

pkg_postinst() {
	if [ `use pcc` ] ; then
		echo
		einfo "OSS sound output may not work on ppc"
		einfo "If your hear only static noise, try"
		einfo "changing the sound device to ALSA or arts"
	fi
}
