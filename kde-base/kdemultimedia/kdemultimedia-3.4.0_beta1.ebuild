# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.4.0_beta1.ebuild,v 1.7 2005/02/02 13:13:24 lanius Exp $

inherit kde-dist flag-o-matic

DESCRIPTION="KDE multimedia apps: noatun, kscd, juk..."

KEYWORDS="~x86 ~amd64"
IUSE="alsa audiofile encode flac gstreamer oggvorbis speex theora xine"

DEPEND="~kde-base/kdebase-${PV}
	media-sound/cdparanoia
	audiofile? ( media-libs/audiofile )
	flac? ( media-libs/flac )
	encode? ( media-sound/lame )
	oggvorbis? ( media-sound/vorbis-tools )
	xine? ( >=media-libs/xine-lib-1_beta12 )
	alsa? ( media-libs/alsa-lib )
	speex? ( media-libs/speex )
	theora? ( media-libs/libtheora )
	gstreamer? ( >=media-libs/gstreamer-0.8
		     >=media-libs/gst-plugins-0.8 )
	>=media-libs/taglib-1.2
	media-libs/tunepimp
	!media-sound/juk"

src_unpack() {
	kde_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	use xine && myconf="$myconf --with-xine-prefix=/usr"
	use xine || DO_NOT_COMPILE="$DO_NOT_COMPILE xine_artsplugin"

	myconf="${myconf} --with-cdparanoia --enable-cdparanoia"

	# make -j2 fails, at least on ppc
	use ppc && export MAKEOPTS="$MAKEOPTS -j1"
	use hppa && append-flags -ffunction-sections

	use alsa	&& myconf="$myconf --with-alsa --with-arts-alsa" || myconf="$myconf --without-alsa --disable-alsa"
	use oggvorbis	&& myconf="$myconf --with-vorbis=/usr" || myconf="$myconf --without-vorbis"
	use encode	&& myconf="$myconf --with-lame=/usr" || myconf="$myconf --without-lame"

	kde_src_compile
}
