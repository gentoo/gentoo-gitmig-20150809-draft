# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="debug nls oggvorbis arts truetype alsa"
filter-flags "-funroll-loops"
filter-flags "-maltivec -mabi=altivec"
inherit eutils

MY_P=${P}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Great Video editing/encoding tool. New, gtk2 version"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/x11
	media-sound/mad
	>=media-libs/a52dec-0.7.4
	>=media-sound/lame-3.93
	>=media-video/mjpegtools-1.6
	>=media-libs/xvid-0.9
	>=dev-libs/libxml2-2.5.7
	>=x11-libs/gtk+-2.2.1
	x86? ( >=media-libs/divx4linux-20030428 )
	x86? ( dev-lang/nasm )
	nls? ( >=sys-devel/gettext-0.11.2 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	arts? ( >=kde-base/arts-1.1.1 )
	truetype? ( >=media-libs/freetype-2.1.2 )
	alsa? ( >=media-libs/alsa-lib-0.9.1 )"
# media-sound/toolame is supported as well


src_compile() {
	# Fixes a possible automake error due to clock skew
	touch -r *

	# Fixes mmx/endian detection in configure.in for use in ppc
	cd ${S}; epatch ${FILESDIR}/${MY_P}-ppc-configure.patch

	# Fixes a save/jpeg - bug
	cd ${S}/avidemux; epatch ${FILESDIR}/patch_jpeg.diff; cd ${S}

	export WANT_AUTOCONF_2_5=1
	autoconf

	# invalid cast
	use ppc \
		&& cd avidemux/ADM_video/ \
		&& sed -e '188s/const//g' ADM_vidFont.cpp > ADM_vidFont.cpp.new \
		&& mv ADM_vidFont.cpp.new ADM_vidFont.cpp \
		&& cd ../..

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

pkg_postinst() {

	if [ -n "`use pcc`" ]
	then
		echo
		einfo "OSS sound output may not work on ppc"
		einfo "If your hear only static noise, try"
		einfo "changing the sound device to ALSA or arts"
	fi
}
