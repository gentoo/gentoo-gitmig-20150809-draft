# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.3.0_beta2.ebuild,v 1.2 2004/07/28 13:51:09 caleb Exp $

inherit kde-dist flag-o-matic

DESCRIPTION="KDE multimedia apps: noatun, kscd, artsbuilder..."

KEYWORDS="~x86 ~amd64"
IUSE="flac encode oggvorbis alsa xine speex"

DEPEND="~kde-base/kdebase-${PV}
	media-sound/cdparanoia
	flac? ( media-libs/flac )
	encode? ( media-sound/lame )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	xine? ( >=media-libs/xine-lib-1_beta12 )
	alsa? ( media-libs/alsa-lib )
	speex? ( media-libs/speex )
	media-sound/trm
	media-libs/taglib
	!media-sound/juk"

src_unpack() {
	kde_src_unpack
}

src_compile() {
	replace-flags -O3 -O2
	# Still persists with 3.2.1 - kaboodle
	filter-flags "-fno-default-inline"

	myconf="$myconf --with-xine-prefix=/usr"

	# make -j2 fails, at least on ppc
	use ppc && export MAKEOPTS="$MAKEOPTS -j1"
	use hppa && append-flags -ffunction-sections

	# alsa 0.9 not supported
	use alsa	&& myconf="$myconf --with-alsa --with-arts-alsa" || myconf="$myconf --without-alsa --disable-alsa"
	use oggvorbis	&& myconf="$myconf --with-vorbis=/usr"		|| myconf="$myconf --without-vorbis"
	use encode	&& myconf="$myconf --with-lame=/usr" || myconf="$myconf --without-lame"

	myconf="$myconf --disable-strict --disable-warnings"

	kde_src_compile
}
